// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MembershipNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // create svg

    event NewMembershipNFTMinted(address sender, uint256 tokkenId);
    
    constructor() ERC721 ("MembershipNFT", "Membership") {
    }
    
    function MintMembershipNFT() public {
        // add logic
        // create encoding
    }

}