//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
// Import OpenZeppelin contract
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
// Import BenQi contracts
import { ComptrollerInterface } from "./BenQi/ComptrollerInterface.sol";
import { PriceOracleInterface } from "./BenQi/PriceOracleInterface.sol";
import { QiAvaxInterface } from "./BenQi/QiAvaxInterface.sol";
import { QiErc20Interface } from "./BenQi/QiErc20Interface.sol";
import { QiTokenInterface } from "./BenQi/QiTokenInterface.sol";

// A contract that allows borrowing ETH using USDC as collateral on Benqi
contract DeFi {
    address ethBenqiMarketAddress = 0x906F11f3087ad54Dbf618E763427BD98AF16Bf9C; // ETH as the token that we want to borrow
    address comptrollerAddress = 0x0fEC306943Ec9766C1Da78C1E1b18c7fF23FE09e;
    address qiCollateralTokenAddress = 0x51203d73c94273C495F5d515dE87795649c21D53; // use USDC as the collateral
    address usdcAddress = 0x45ea5d57BA80B5e3b0Ed502e9a08d568c96278F9;

    constructor() {}

    function borrowAsset(uint256 _borrowAmount, uint256 _collateralAmount) public {
        addCollateral(_collateralAmount);
        enterMarkets();
        uint256 errorCode = QiErc20Interface(ethBenqiMarketAddress).borrow(_borrowAmount);
        console.log("Error code: ", errorCode); // successful if error code is 0
    }

    function enterMarkets() internal {
        // Check membership
        bool isCollateralMember = ComptrollerInterface(comptrollerAddress).checkMembership(
            address(this),
            qiCollateralTokenAddress
        );
        console.log("Is collateral member: ", isCollateralMember);

        // If already entered market, do nothing
        if (isCollateralMember) return;

        // Add markets to enter
        address[] memory markets = new address[](1);
        markets[0] = qiCollateralTokenAddress;

        // Enter markets
        ComptrollerInterface(comptrollerAddress).enterMarkets(markets);
    }

    function addCollateral(uint256 _collateralAmount) internal {
        // Approve for collateral
        IERC20Metadata(usdcAddress).approve(qiCollateralTokenAddress, _collateralAmount);

        // Add collateral
        QiErc20Interface(qiCollateralTokenAddress).mint(_collateralAmount);
    }
}
