const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Dog Coin", function () {

  let admin, users;

  beforeEach(async function() {
    [admin, users] = await ethers.getSigners();
  });

  it("Should use Enumerable Set correctly", async function () {
    const DogCoin = await ethers.getContractFactory("DogCoin");
    const dogcoin = await DogCoin.deploy();
    await dogcoin.deployed();

    await dogcoin.mint(ethers.utils.parseEther("1")); 

    expect(await dogcoin.checkTokenHolder(admin.address)).to.equal(true);
    expect(await dogcoin.checkTokenHolder(users.address)).to.equal(false);
  });
});
