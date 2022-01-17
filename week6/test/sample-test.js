// command to start local fork
// npx ganache-cli -f https://mainnet.infura.io/v3/0842113999df48a8a354df21fe0ea695 --unlock 0x503828976D22510aad0201ac7EC88293211D23Da -p 8545

const { expect, use } = require("chai");
const { ethers } = require("hardhat");

const { solidity } = require("ethereum-waffle");
use(solidity);

const DAIAddress = "0x6b175474e89094c44da98b954eedeac495271d0f";
const USDCAddress = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";

describe("DeFi", () => {
  let owner;
  let DAI_TokenContract;
  let USDC_TokenContract;
  let DeFi_Instance;
  const INITIAL_AMOUNT = 999999999000000;
  before(async function () {
    [owner, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();
    const whale = await ethers.getSigner(
      "0x503828976D22510aad0201ac7EC88293211D23Da"
    );
    console.log("owner account is ", owner.address);

    DAI_TokenContract = await ethers.getContractAt("ERC20", DAIAddress);
    USDC_TokenContract = await ethers.getContractAt("ERC20", USDCAddress);
    const symbol = await DAI_TokenContract.symbol();
    console.log(symbol);
    const DeFi = await ethers.getContractFactory("DeFi");

    await DAI_TokenContract.connect(whale).transfer(
      owner.address,
      BigInt(INITIAL_AMOUNT)
    );

    DeFi_Instance = await DeFi.deploy();
  });

  it("should make a swap", async () => {
    await DAI_TokenContract.connect(owner).transfer(DeFi_Instance.address, BigInt(INITIAL_AMOUNT));
    expect(await DAI_TokenContract.balanceOf(DeFi_Instance.address)).to.equal(BigInt(INITIAL_AMOUNT));
    let USDCBalance = await USDC_TokenContract.balanceOf(owner.address);
    console.log("USDC Balance before: ", USDCBalance);
    await DeFi_Instance.connect(owner).swapDAItoUSDC(BigInt(INITIAL_AMOUNT));
    USDCBalance = await USDC_TokenContract.balanceOf(owner.address);
    console.log("USDC Balance after: ", USDCBalance);
    expect(await DAI_TokenContract.balanceOf(DeFi_Instance.address)).to.equal(0);
  });
});
