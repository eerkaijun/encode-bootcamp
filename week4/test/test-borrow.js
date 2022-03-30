const { expect } = require("chai");
const { ethers } = require("hardhat");

const BENQI_ERC20_ABI = (() => {

  const abi = require('@pangolindex/exchange-contracts/artifacts/contracts/pangolin-core/PangolinERC20.sol/PangolinERC20.json').abi;
  abi.push({
    "constant": false,
    "inputs": [
      {
        "internalType": "address",
        "name": "receiver",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "amount",
        "type": "uint256"
      }
    ],
    "name": "allocateTo",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "payable": false,
    "stateMutability": "nonpayable",
    "type": "function"
  });

  // return
  return abi;

})();

describe("Benqi", function () {

  let user, users;
  let contract;

  beforeEach(async function() {
    users = await ethers.getSigners();
    user = users[0];
    const DeFi = await ethers.getContractFactory("DeFi");
    contract = await DeFi.deploy();
    await contract.deployed();
  });

  it("Should be able to borrow asset from Benqi ", async function () {
    // get USDC token deployed on Fuji testnet
    const USDC = await ethers.getContractAt(
      BENQI_ERC20_ABI,
      ethers.utils.getAddress("0x45ea5d57ba80b5e3b0ed502e9a08d568c96278f9"),
      user,
    );
    const decimals = await USDC.decimals();
    console.log("Number of decimals: ", decimals);
    // mint USDC to contract address so that we could borrow asset
    await USDC.allocateTo(
      contract.address,
      ethers.utils.parseUnits('100000', decimals)
    );
    //console.log("USDC balance of DeFi contract: ", await USDC.balanceOf(contract.address));

    const ETH = await ethers.getContractAt(
      BENQI_ERC20_ABI,
      ethers.utils.getAddress("0x4f5003fd2234Df46FB2eE1531C89b8bdcc372255"),
      user
    )

    // before borrow, ETH balance of contract should be zero
    expect(await ETH.balanceOf(contract.address)).to.equal(0);

    // borrow 1 ETH
    let borrowValue = 1;
    await contract.borrowAsset(
      ethers.utils.parseUnits(borrowValue.toString(), 18),
      ethers.utils.parseUnits('100000', decimals)
    )

    console.log("After borrow:");
    console.log("USDC Balance: ", (await USDC.balanceOf(contract.address)).toString());
    console.log("ETH Balance: ", (await ETH.balanceOf(contract.address)).toString());
  });
});
