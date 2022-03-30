// SPDX-License-Identifier: BUSL-1.1
// Source: https://github.com/Benqi-fi/BENQI-Smart-Contracts/blob/master/QiTokenInterfaces.sol
pragma solidity >=0.8.0 <0.9.0;

interface QiErc20Interface {

    function mint(uint mintAmount) external returns (uint);
    function redeem(uint redeemTokens) external returns (uint);
    function redeemUnderlying(uint redeemAmount) external returns (uint);
    function borrow(uint borrowAmount) external returns (uint);
    function repayBorrow(uint repayAmount) external returns (uint);
    function repayBorrowBehalf(address borrower, uint repayAmount) external returns (uint);
    function liquidateBorrow(address borrower, uint repayAmount, address qiTokenCollateral) external returns (uint);

}
