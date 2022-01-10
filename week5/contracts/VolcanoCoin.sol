// SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity ^0.8.0;

contract VolcanoCoin is ERC20, Ownable {
    
    mapping(address => Payment[]) public transfers;
    
    struct Payment {
        uint amount;
        address receiver;
    }
    
    constructor() ERC20("Encode Bootcamp", "ENCODE") {
        _mint(msg.sender, 10000);
    }
    
    function increaseOwnerSupply(uint _amount) public onlyOwner {
        _mint(msg.sender, _amount);
    }
    
    function transfer(address recipient, uint amount) public virtual override returns(bool) {
        _transfer(msg.sender, recipient, amount);
        transfers[msg.sender].push(Payment(amount, recipient));
        emit tokensTransferred(amount, recipient);
        return true;
    }
    
    event tokensTransferred(uint _amount, address _receiver);
}
