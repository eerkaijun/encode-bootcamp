// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/Contract.sol";

contract ContractTest is Test, Contract {
    function setUp() public {}

    function testExample() public {
        assertTrue(true);
    }

    function testCount() public {
        assertEq(count, 0);
    }

    function testAdd(uint256 fuzzy) public {
        // forge supports fuzzy testing, which means random amount of data as inputs
        add(fuzzy);
        assertEq(count, fuzzy);
    }
}
