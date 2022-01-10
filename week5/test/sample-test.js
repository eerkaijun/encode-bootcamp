const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("VolcanoCoin", function () {
  it("Should return version number", async function () {
    const Coin = await ethers.getContractFactory("VolcanoCoin");
    const coin = await Coin.deploy();
    await coin.deployed();

    expect(await coin.version()).to.equal(1);
  });
});
