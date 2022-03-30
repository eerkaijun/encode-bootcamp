// SPDX-License-Identifier: BUSL-1.1
// Source: https://github.com/Benqi-fi/BENQI-Smart-Contracts/blob/master/ComptrollerInterface.sol
pragma solidity >=0.8.0 <0.9.0;

interface ComptrollerInterface {

    //--- Compound lib start
    function enterMarkets(address[] calldata qiTokens) external returns (uint[] memory);
    function exitMarket(address qiToken) external returns (uint);

    function mintAllowed(address qiToken, address minter, uint mintAmount) external returns (uint);
    function mintVerify(address qiToken, address minter, uint mintAmount, uint mintTokens) external;

    function redeemAllowed(address qiToken, address redeemer, uint redeemTokens) external returns (uint);
    function redeemVerify(address qiToken, address redeemer, uint redeemAmount, uint redeemTokens) external;

    function borrowAllowed(address qiToken, address borrower, uint borrowAmount) external returns (uint);
    function borrowVerify(address qiToken, address borrower, uint borrowAmount) external;

    function repayBorrowAllowed(
        address qiToken,
        address payer,
        address borrower,
        uint repayAmount) external returns (uint);
    function repayBorrowVerify(
        address qiToken,
        address payer,
        address borrower,
        uint repayAmount,
        uint borrowerIndex) external;

    function liquidateBorrowAllowed(
        address qiTokenBorrowed,
        address qiTokenCollateral,
        address liquidator,
        address borrower,
        uint repayAmount) external returns (uint);
    function liquidateBorrowVerify(
        address qiTokenBorrowed,
        address qiTokenCollateral,
        address liquidator,
        address borrower,
        uint repayAmount,
        uint seizeTokens) external;

    function seizeAllowed(
        address qiTokenCollateral,
        address qiTokenBorrowed,
        address liquidator,
        address borrower,
        uint seizeTokens) external returns (uint);
    function seizeVerify(
        address qiTokenCollateral,
        address qiTokenBorrowed,
        address liquidator,
        address borrower,
        uint seizeTokens) external;

    function transferAllowed(address qiToken, address src, address dst, uint transferTokens) external returns (uint);
    function transferVerify(address qiToken, address src, address dst, uint transferTokens) external;

    function liquidateCalculateSeizeTokens(
        address qiTokenBorrowed,
        address qiTokenCollateral,
        uint repayAmount) external view returns (uint, uint);

    // membership
    function checkMembership(address account, address qiToken) external view returns (bool);
    
    // liquidity
    function getAccountLiquidity(address account) external view returns (uint, uint, uint);

    // markets
    function markets(address cTokenAddress) external view returns (bool, uint, bool);

    // oracle
    function oracle() external view returns (address);

}
