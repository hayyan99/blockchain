// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0

pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(address recipient) ERC20("MyToken", "MTK") {
        _mint(recipient, 100000 * 10 ** decimals());
    }
}

contract ERC20Auction{
    struct Listing{
        address seller;
        IERC20 token;
        uint pricePerToken;
        uint remainingAmount;
    }

    Listing[] public listings;

    //listing tokens for sale
    function listTokens(IERC20 token, uint amount, uint price) external {
        require(amount > 0 && price > 0, "Invalid amount or price");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    function buyTokens(uint listingid, uint amount, uint deadline) external payable{
        //time-limit(safeguards)
        require(block.timestamp <= deadline,"Expired");
        require(listingid < listings.length, "Invalid listing");

        Listings storage listing = listings[id];

        require(amount <= listings.remaining, "Not enough tokens");

        uint totalPrice = amount * listing.pricePerToken;
        require(msg.value >= totalPrice, "Not enough ETH");
        
        listing.remaining -= amount;
        listing.token.transferFrom(msg.sender, address(this), amount);
        payable(listing.seller).transfer(totalPrice);

        if (msg.value > totalPrice) {
            payable(msg.sender).transfer(msg.value - totalPrice);
        }
    }

    function getListCount() external view returns (uint){
        return listings.length;
    }
}
