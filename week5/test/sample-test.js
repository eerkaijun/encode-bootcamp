const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("VolcanoCoin", function () {
  it("Should return version number", async function () {
    const Coin = await ethers.getContractFactory("VolcanoCoin");
    const coin = await upgrades.deployProxy(Coin, { kind: 'uups' });
    //const coin = await Coin.deploy();
    await coin.deployed();
    console.log("Volcano coin contract deployed to: ", coin.address);

    expect(await coin.version()).to.equal(1);
  });
});
