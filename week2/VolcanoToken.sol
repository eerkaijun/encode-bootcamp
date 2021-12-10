// SPDX-License-Identifier: UNLICENSED

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.0;

contract VolcanoToken is ERC721, Ownable {

    uint256 tokenID = 0;
    struct Token {
        uint256 timestamp;
        uint256 tokenID;
        string tokenURI;
    }
    mapping(address => Token[]) tokens;

    constructor() ERC721("Encode Bootcamp", "ENCODE") {
    }

    function createToken(address _to) public onlyOwner {
        _safeMint(_to, tokenID);
        Token memory newToken = Token(block.timestamp, tokenID, "");
        tokens[_to].push(newToken);
        tokenID++;
    }

    function burnToken(uint256 _tokenID) public {
        require(msg.sender == ownerOf(_tokenID));
        _burn(_tokenID);
        removeToken(_tokenID, msg.sender);
    }

    function removeToken(uint256 _tokenID, address _owner) private {
        Token[] storage toBeRemoved = tokens[_owner];
        for (uint i = 0; i < toBeRemoved.length; i++) {
            if (toBeRemoved[i].tokenID == _tokenID) {
                delete toBeRemoved[i];
            }
        }
    }

    function tokenURI(uint256 _tokenID) public view override returns (string memory) {
        address owner = ownerOf(_tokenID);
        Token[] memory allTokens = tokens[owner];
        for (uint i = 0; i < allTokens.length; i++) {
            if (allTokens[i].tokenID == _tokenID) {
                return allTokens[i].tokenURI;
            }
        }
        return "";
    }

}
