## Setup
Clone the repo and install packages
```
git clone https://github.com/giobiba/Ethereum-voting-app.git
npm install
```
## Opening the ganache CLI
`ganache CLI` helps us test our app while in development, by creating an environment for us to use the ethereum technology with mock accounts that are preloaded with fake ethereum. To run it we simply use the command `node-modules/.bin/ganache-cli`. When we run it you can see something like this:
```
Ganache CLI v6.12.2 (ganache-core: 2.13.2)
Available Accounts
==================

(0) 0x7B399ccf1cd684ec6535670dBD62001808ED012e (100 ETH)
(1) 0x9cBA53088590C65A064c830cc1D77b249e114337 (100 ETH)
(2) 0x79488B229577a3F72610DB55bea830fD7352e04F (100 ETH)
(3) 0xa1D92f6384494d3cDE5F880526961a91166273Fa (100 ETH)
(4) 0x2bEd42f953708996879828AF79bE16bEAE16D2f4 (100 ETH)
(5) 0xdfb3D38b4F6602F210bDF495971f480da86f75A5 (100 ETH)
(6) 0xD38d2465941b883F37C8F36d8C9DFc66A8Cf8898 (100 ETH)
(7) 0x3737fc91B90f62923266d06647BaFCe975723574 (100 ETH)
(8) 0x260bE1E40Fa94eFcEb9745BcF9f7d2DAae670812 (100 ETH)
(9) 0x37CF0bC68652CE8cFD687EDB0303762DdFd82240 (100 ETH)

Private Keys
==================

(0) 0x4fdfa1361796a27e505f99936ad57f554a8314243bc4baf0598c18f140e75095
(1) 0xb44f8435fad0777c037a0906233674a703b912eba647c84e3efc126407935451
(2) 0xaf30121ddb7567e5dc0a0537994239a71a9098d786dd541a3b31a2f391da0626
(3) 0x9fa9e53d0d5d4fbe07fd39180a6a846bdb8adc6d185bf0244d31b75a21c48376
(4) 0x04db8b52869ad28b819d8a081f063ca63e518b6fab793f70cafe0c2db4891c94
(5) 0xda4a22f0a76427b9f80e46bf2be2ca9205b22e46234bf5352394ab9777bfc3be
(6) 0x4f642ec9f965ab927b48f83be8b1038d526cf02e85ba63db400558eb95d98141
(7) 0x74f7ba299fca9656d9d711c06831176bc5e1f551d9138bab631fde91f1c4eee0
(8) 0xe36d1c89238ff6eaba2dfc52b056b25d19cfdb7e8a12df1cdac1dac6acdb934b
(9) 0x5bb1acae5c2de9cc665cedc59df27f7faf88f4604302868a052d20195dad1397

HD Wallet
==================

Mnemonic: three diesel bread tilt boy else excess hire squeeze rotate critic engine
Base HD Path: m/44'/60'/0'/0/{account_index}

Gas Price
==================
20000000000

Gas Limit
==================
6721975

Call Gas Limit
==================
9007199254740991

Listening on 127.0.0.1:8545
```
We can see that it created 10 available accounts, that we will use later

## Compiling the contract
To do this you need to run the following command, while being inside the root 
```
node_modules/.bin/solcjs --bin --abi voting.sol 
```
This will generate two files, the .bin and .abi
* .bin has the bytecode of the compiled source code in voting.sol
* .abi contains the interface to the contract, with all the methods and attributes
After compiling we can test our contract in the nodejs console by running `node`
```js
// import the web3js library to interact with the blockchain
Web3 = require('web3')
// create the provider object
web3provider = new Web3.providers.HttpProvider('http://localhost:8545')
// create the web3 object
web3 = new Web3(web3provider)
// we can check that web3 has connected properly to ganache by the following command
web3.eth.getAccounts(console.log)
// which will log all the accounts that we've got, identical to those from above

// now we want to read the two files compiled above 
bytecode = fs.readFileSync('voting_sol_Voting.bin').toString()
abi = JSON.parse(fs.readFileSync('voting_sol_Voting.abi').toString())
// and we'll deploy the contract by using the following command 

candidati = ['Macron', 'Le Pen', 'Melenchon']

deployedContract.deploy({
	data:bytecode,
	arguments: [candidati.map(name => web3.utils.asciiToHex(name))]
	}).send({
		from: '..some eth account..',
		gas:1500000,
		gasPrice: web3.utils.toWei('0.00003', 'ether')
	}).then((newContractInstance) => {
		deployedContract.options.address = newContractInstance.options.address
		console.log(newContractInstance.options.address)});

/*
data - the compiled bytecode 
arguments - the ones that will be passed to our constructor
from - the account that deploys the contract
gas - the cost to interact with the blockchain
gasprice - price associated with the gas
*/

// after we have done this we can interact with the blockchain
deployedContract.methods.totalVoturi(web3.utils.asciiToHex('Le Pen')).call(console.log)
// this will output the number of votes for the given candidate, in our case 'Le Pen', in our case 0 since we've just deployed our contract

// we can also vote for someone by using this method and if we would run the previous command again the return value would be 1
deployedContract.methods.vot(web3.utils.asciiToHex('Le Pen')).send({from: '..some eth account..'}).then((f) => console.log(f))

```
