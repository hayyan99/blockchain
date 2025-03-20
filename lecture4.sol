// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(address owner) ERC20("MyToken", "MTK") {
        _mint(owner, 500 * 10 ** decimals());
    }
}


contract staking{
    MyToken public token;
    address public owner;
    mapping (address =>uint) public stackedAmount;    

    constructor(address add) {
        token = MyToken(add);
        owner = msg.sender;
    }

    
    function stake() public{
        uint256 amount = 100 * 10 ** 18;
        uint256 bonusamount = (amount * 5) / 100;
        
        require(token.transferFrom(msg.sender,address(this),amount), "Stake failed");
        stackedAmount[msg.sender] += amount + bonusamount;
    }

    function unstake() public {
        uint256 amount = stackedAmount[msg.sender];
        require(amount > 0, "No tokens to unstake");

        stackedAmount[msg.sender] = 0;
        require(token.transfer(msg.sender, amount), "Unstake failed");
    }
}