const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Chainlink Consumer", function () {
  it("Should return a verifiable random number", async function () {
    const Consumer = await ethers.getContractFactory("VRFv2Consumer");
    const consumer = await Consumer.deploy(2723);
    await consumer.deployed();

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
