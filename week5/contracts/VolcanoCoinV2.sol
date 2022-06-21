// SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";


pragma solidity ^0.8.0;

contract VolcanoCoinV2 is Initializable, ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {

    uint public constant version = 2;
    
    mapping(address => Payment[]) public transfers;
    
    struct Payment {
        uint amount;
        address receiver;
    }
    
    // constructor() ERC20("Encode Bootcamp", "ENCODE") {
    //     _mint(msg.sender, 10000);
    // }

    function initialize() initializer public {
        __ERC20_init("Encode Bootcamp", "ENCODE");
        __Ownable_init();
        __UUPSUpgradeable_init();
        _mint(msg.sender, 10000);
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}
    
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