// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract dummyToken{
    mapping (address => uint) public balanceOf;
    uint cap = 100000;
    address public owner = msg.sender;
    uint public totalSupply;

    function deposit(uint amount) public{
        balanceOf[msg.sender] += amount;
    }
    
    function mint(uint amount) public returns (bool) {
        require(msg.sender == owner, "Only owner can mint");
        require(amount > 0, "Amount should be greater than zero!");
        require(totalSupply + amount < 0, "Cap reached");
        balanceOf[msg.sender] += amount;
        totalSupply += amount;

        return true;
    }

    function transfer(address sender, address recipient, uint amount) public returns (bool){
        
        require(balanceOf[sender] >= amount, "Insufficient balance!");
        require(recipient != address(0), "Zero address detected");
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;

        return true;

    }
}