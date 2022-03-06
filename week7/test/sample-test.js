// command to start local fork
// npx ganache-cli -f https://mainnet.infura.io/v3/0842113999df48a8a354df21fe0ea695 --unlock 0x503828976D22510aad0201ac7EC88293211D23Da -p 8545

const { expect, use } = require("chai");
const { ethers } = require("hardhat");

const { solidity } = require("ethereum-waffle");
use(solidity);

const DAIAddress = "0x6b175474e89094c44da98b954eedeac495271d0f";
const cDAIAddress = "0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643";

describe("DeFi", function () {

  const INITIAL_AMOUNT = 999999999000000;
  let owner;
  let DAI_TokenContract;
  let cDAI_TokenContract;
  let DeFi_Instance;

  before(async function () {
    [owner, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();
    const whale = await ethers.getSigner(
      "0x503828976D22510aad0201ac7EC88293211D23Da"
    );
    console.log("owner account is ", owner.address);

    DAI_TokenContract = await ethers.getContractAt("Erc20", DAIAddress);
    cDAI_TokenContract = await ethers.getContractAt("CErc20", cDAIAddress);
    const DeFi = await ethers.getContractFactory("DeFi");

    await DAI_TokenContract.connect(whale).transfer(
      owner.address,
      BigInt(INITIAL_AMOUNT)
    );

    DeFi_Instance = await DeFi.deploy();
    await DeFi_Instance.deployed();
  });
 
  it("Should be able to deposit to Compound", async function () {
    await DAI_TokenContract.connect(owner).transfer(
      DeFi_Instance.address,
      INITIAL_AMOUNT
    );
    expect(await DAI_TokenContract.balanceOf(DeFi_Instance.address)).to.equal(INITIAL_AMOUNT);

    let tx = await DeFi_Instance.connect(owner).addToCompound(INITIAL_AMOUNT);
    tx.wait();

    const cDAIBalance = await cDAI_TokenContract.balanceOf(DeFi_Instance.address);
    console.log("Balance: ", cDAIBalance);
  });

  it("Should be able to get chainlink price feed data", async function() {
    let ethPrice = await DeFi_Instance.getLatestPrice();
    console.log("ETH Price: ", ethPrice);
  })
});
