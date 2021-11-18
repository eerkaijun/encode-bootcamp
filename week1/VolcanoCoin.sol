// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint64 totalSupply = 10000;
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function getTotalSupply() public view returns(uint64) {
        return totalSupply;
    }
    
    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit supplyIncreased(totalSupply);
    }
    
    event supplyIncreased(uint64 _newSupply);
}
