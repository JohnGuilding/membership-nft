// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MembershipNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string svgPartOne = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string svgPartTwo = "'/><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";
    string svgPartThree = "</text></svg>";
    string[] colours = ["red", "orange", "yellow", "green", "blue", "purple", "black"];

    event NewMembershipNFTMinted(address sender, uint256 tokenId);
    
    constructor() ERC721 ("MembershipNFT", "Membership") {
    }

    function pickRandomColour(uint256 _tokenId) internal view returns (string memory) {
        string memory input = string(abi.encodePacked("COLOUR", Strings.toString(_tokenId)));
        uint256 randomInt = uint256(keccak256(abi.encodePacked(input)));

        randomInt = randomInt % colours.length;
        return colours[randomInt];
    }
    
    function mintMembershipNFT(string memory _username) public {
        uint256 newItemId = _tokenIds.current();
        string memory randomColour = pickRandomColour(newItemId);

        // What other details should we add to this membership nft??
        string memory finalSvg = string(
            abi.encodePacked(
                svgPartOne,
                randomColour,
                svgPartTwo,
                _username,
                svgPartThree));

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        _username,
                        '", "description": "A membership NFT", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log(finalTokenUri);

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        emit NewMembershipNFTMinted(msg.sender, newItemId);
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    }

}