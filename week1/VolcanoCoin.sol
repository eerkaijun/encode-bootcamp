// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin {
    
    uint64 totalSupply = 10000;
    address owner;
    mapping(address => uint) public balances;
    mapping(address => Payment[]) public transfers;
    
    struct Payment {
        uint64 amount;
        address receiver;
    }
    
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
    
    function transfer(uint64 _amount, address _receiver) public {
        require(balances[msg.sender] >= _amount);
        transfers[msg.sender].push(Payment(_amount, _receiver));
        balances[msg.sender] -= _amount;
        balances[_receiver] += _amount;
        emit tokensTransferred(_amount, _receiver);
    }
    
    event supplyIncreased(uint64 _newSupply);
    event tokensTransferred(uint64 _amount, address _receiver);
}
