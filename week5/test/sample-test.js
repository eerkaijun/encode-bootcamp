const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("VolcanoCoin", function () {
  it("Should return version number correctly after upgrade", async function () {
    const Coin = await ethers.getContractFactory("VolcanoCoin");
    const coin = await upgrades.deployProxy(Coin, { kind: 'uups' });
    //const coin = await Coin.deploy();
    await coin.deployed();
    console.log("Volcano coin contract deployed to: ", coin.address);

    expect(await coin.version()).to.equal(1);

    const CoinNew = await ethers.getContractFactory("VolcanoCoinV2");
    const coinNew = await upgrades.upgradeProxy(coin.address, CoinNew);
    await coinNew.deployed();
    console.log("New Volcano coin contract deployed to: ", coinNew.address);

    expect(await coinNew.version()).to.equal(2);
  });
});
