//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
// Import BenQi contracts
import { ComptrollerInterface } from "./BenQi/ComptrollerInterface.sol";
import { PriceOracleInterface } from "./BenQi/PriceOracleInterface.sol";
import { QiAvaxInterface } from "./BenQi/QiAvaxInterface.sol";
import { QiErc20Interface } from "./BenQi/QiErc20Interface.sol";
import { QiTokenInterface } from "./BenQi/QiTokenInterface.sol";

contract DeFi {
    address avaxBenqiMarketAddress = 0x219990FA1f91751539c65aE3f50040C6701cF219; // AVAX as the token that we want to borrow
    address comptrollerAddress = 0x0fEC306943Ec9766C1Da78C1E1b18c7fF23FE09e;
    address qiCollateralTokenAddress = 0x51203d73c94273C495F5d515dE87795649c21D53; // use USDC as the collateral

    constructor() {}

    function borrowAsset(uint256 _amount) public {
        enterMarkets();
        uint256 errorCode = QiErc20Interface(avaxBenqiMarketAddress).borrow(_amount);
        console.log("Error code: ", errorCode);
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
}
