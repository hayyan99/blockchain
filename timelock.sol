// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit {
    constructor(address recipient)
        ERC20("MyToken", "MTK")
        ERC20Permit("MyToken")
    {
        _mint(recipient, 100000 * 10 ** decimals());
    }
}

contract Timelocktoken {
    MyToken public token;
    address public owner;
    uint public unlocktime;

    event Tokenlocks(uint256 amount, uint256 unlocktime);
    event Tokenwithdrawn(uint256 amount);

    constructor(address _token, uint256 _lockduration){
        token = MyToken(_token);
        owner = msg.sender;
        unlocktime = block.timestamp + _lockduration;
    }

    function getUnlocktime(uint256 amount) external{
        require(msg.sender == owner,"Owner can only lock.");
        require(amount > 0, "Amount must greater than zero");
        require(token.balanceOf(address(this)) >= amount,"Not enough balance");
        emit Tokenlocks(amount, unlocktime); 
    }

    function withdrawTokens() external {
        require(msg.sender == owner,"Only owner can withdraw tokens.");
        require(unlocktime <= block.timestamp, "Cannot Withdraw before unlock time");
        uint256 balance = token.balanceOf(address(this));
        require(token.transfer(owner, balance), "Transfer failed");
        emit Tokenwithdrawn(balance);
    }
}

