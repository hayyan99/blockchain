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
    mapping (address =>uint) public stakeTimestamp;
    uint256 public staketime = 24 hours;
    
    constructor(address add) {
        token = MyToken(add);
        owner = msg.sender;
    }

    
    function stake(uint256 amount) public{
        require(amount > 0 ,"Amount must be greater than 0");
        uint256 bonusamount = (amount * 5) / 100;

        require(token.balanceOf(msg.sender) >= amount, "Insufficient balance to stake");
        require(token.transferFrom(msg.sender,address(this),amount), "Stake failed");
        stackedAmount[msg.sender] += amount + bonusamount;

        stakeTimestamp[msg.sender] = block.timestamp;
    }

    function unstake() public {
        uint256 amount = stackedAmount[msg.sender];
        require(amount > 0, "No tokens to unstake");
        require(block.timestamp >= stakeTimestamp[msg.sender] + staketime, "Cannot stake before 24 hrs!");

        uint256 stakeday = (block.timestamp - stakeTimestamp[msg.sender]) / 1 days;
        
        uint256 reward = (stakeday > 0) ? (amount * stakeday) / 100 : 0;
        uint256 totalamount = amount + reward;

        
        stackedAmount[msg.sender] = 0;
        stakeTimestamp[msg.sender] = 0;
        require(token.transfer(msg.sender, totalamount), "Unstake failed");
    }
}
  