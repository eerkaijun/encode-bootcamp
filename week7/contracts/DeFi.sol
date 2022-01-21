// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface Erc20 {
    function approve(address, uint256) external returns (bool);
    function transfer(address, uint256) external returns (bool);
}

interface CErc20 {
    function mint(uint256) external returns (uint256);
    function exchangeRateCurrent() external returns (uint256);
    function supplyRatePerBlock() external returns (uint256);
    function redeem(uint) external returns (uint);
    function redeemUnderlying(uint) external returns (uint);
}


contract DeFi {
    address DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address cDAI = 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643;
}