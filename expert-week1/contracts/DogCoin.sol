//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import { ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { EnumerableSet } from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

contract DogCoin is ERC20 {

    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private holders; // token holders

    constructor() ERC20("DogCoin", "DOG") {}

    function mint(uint256 amount) public {
        // anyone can mint dog coin
        _mint(msg.sender, amount);
    }

    function _afterTokenTransfer(address from, address to, uint256 amount) internal override {
        address[] memory toCheck = new address[](2);
        toCheck[0] = from;
        toCheck[1] = to;
        for (uint i=0; i<2; i++) {
            if (!holders.contains(toCheck[i]) && balanceOf(toCheck[i]) > 0) {
                holders.add(toCheck[i]);
            } else if (holders.contains(toCheck[i]) && balanceOf(toCheck[i]) == 0) {
                holders.remove(toCheck[i]);
            }
        }    
    }

    function checkTokenHolder(address account) public view returns(bool) {
        // return true if account is a token holder, otherwise false
        return holders.contains(account);
    }
}
