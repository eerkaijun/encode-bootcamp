const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Benqi", function () {

  let users;
  let contract;

  beforeEach(async function() {
    users = await ethers.getSigners();
    const DeFi = await ethers.getContractFactory("DeFi");
    contract = await DeFi.deploy();
    await contract.deployed();
  });

  it("Should be able to borrow asset from Benqi ", async function () {
    let mintValue = 100;
    await contract.borrowAsset(
      ethers.utils.parseUnits(mintValue.toString(), 18)
    )
  });
});
