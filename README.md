# BlockChain-REC
Green Energy Tokens, Block chain powered Renewable energy certificate system developed during the EDF CodeGreen Hackathon

## Technology
This project uses the Truffle Webpack Box as a starting point. The smart contract follows the ERC 721 coin standard for Non Fungible Tokens.  

## Set Up 

The following setup guide is adapted from http://truffleframework.com/boxes/webpack and http://truffleframework.com/docs/advanced/truffle-with-metamask
1. Install Truffle globally. 

```
 npm install -g truffle
```
2. Clone repository and cd into folder.
3. Install all dependencies.
```
npm install
```
4. Run the development console.
* You will see 10 testing accounts and a Mnemonic needed later for Metamask. 
```
truffle develop
```
5. Compile and migrate the smart contract from within development console.
```
compile
migrate
```
6. run the webpack server for front-end reloading. 
* This will not recompile changes to the contract.
```
npm run dev 
```
* View project in browser at location specified

**Step 2 - Install Metamask**

7. Get Metamask browser extension from their site metamaks.io.
8. On the login page click import Existing Den 
9. In the box marked Wallet Seed enter the Mnemonic dipsplayed when truffle develop first run. 
10. Enter password and click okay. 
11. Click on Main Network dropdown and select Custom RPC
12. In the box titles "New RPC URL enter the port specified when truffle develop command run. Likely http://127.0.0.1:9545
13. On upper right account icon, select Account 1 or a different account to test contract.

## Troubleshooting ## 
To do a hard rebuild of the contract, delete the build folder in the project directory and redo steps 4-6. 
