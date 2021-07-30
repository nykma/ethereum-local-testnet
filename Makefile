datadir=./chain
networkid=1919
networkname=nyktestnet

init:
	@echo 'Create and export an PoW network.'
	@echo 'https://hackernoon.com/hands-on-creating-your-own-local-private-geth-node-beginner-friendly-3d45902cc612'
	@echo
	@puppeth --network ${networkname}

geth-init:
	geth --datadir ${datadir} init ${networkname}.json

create-account:
	@echo 'Create a non-password account'
	geth --datadir ${datadir} account new
	geth --datadir ${datadir} account list
run:
	geth --networkid ${networkid} \
	--mine --miner.threads 1 \
	--datadir ${datadir} \
	--nodiscover --rpc --rpcport "8545" --port "30303" --rpccorsdomain "*" --rpcapi eth,web3,personal,net \
	--nat "any" \
	--unlock 0 --password './empty-password' --allow-insecure-unlock \
	--ipcpath ${datadir}/geth.ipc

console:
	geth attach --datadir ${datadir}
