# Integrate Compound Programatically

Interact with Compound programatically by supplying DAI tokens. 

### To run unit tests

First fork from ETH mainnet: 

`npx ganache-cli -f https://mainnet.infura.io/v3/0842113999df48a8a354df21fe0ea695 --unlock 0x503828976D22510aad0201ac7EC88293211D23Da -p 8545`

Then, in another terminal, run the tests:

`npx hardhat test --network fork`