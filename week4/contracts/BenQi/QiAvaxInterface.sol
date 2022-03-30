// SPDX-License-Identifier: BUSL-1.1
// Source: https://github.com/Benqi-fi/BENQI-Smart-Contracts/blob/master/QiTokenInterfaces.sol
pragma solidity >=0.8.0 <0.9.0;

interface QiAvaxInterface {
    function repayBorrow() external payable returns (uint);
}
