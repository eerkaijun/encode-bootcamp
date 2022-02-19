const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("VolcanoCoin", function () {

  let coin;
  let owner, user;

  beforeEach(async function() {

    [owner, user] = await ethers.getSigners();
    //console.log("Owner address: ", owner.address);
    //console.log("User address: ", user.address);

    const Coin = await ethers.getContractFactory("VolcanoCoin");
    coin = await upgrades.deployProxy(Coin, { kind: 'uups' });
    await coin.deployed();
    //console.log("Volcano coin contract deployed to: ", coin.address);
  });

  it("Should return version number correctly after upgrade", async function () {
    expect(await coin.version()).to.equal(1);

    const CoinNew = await ethers.getContractFactory("VolcanoCoinV2");
    const coinNew = await upgrades.upgradeProxy(coin.address, CoinNew);
    await coinNew.deployed();
    //console.log("New Volcano coin contract deployed to: ", coinNew.address);

    expect(await coinNew.version()).to.equal(2);
  });

  it("Should keep the original's contract variable value", async function() {
    await coin.connect(owner).transfer(user.address, 10);
    const result = await coin.balanceOf(user.address);
    //const result = await coin.transfers(owner.address, 0);
    //console.log("Transfer result: ", result); 

    const CoinNew = await ethers.getContractFactory("VolcanoCoinV2");
    const coinNew = await upgrades.upgradeProxy(coin.address, CoinNew);
    await coinNew.deployed();

    expect(await coinNew.balanceOf(user.address)).to.equal(10);
  })
});
