// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lecture2{

    receive() external payable { }
    address payable owner = payable(msg.sender);
    uint public contractBalance = address(this).balance;

    function sendEther() public payable {
        require(msg.value >= 1 ether, "Not enough money");//ensuring that the caller sends 1 ether
        
        contractBalance = address(this).balance;
        payable(owner).transfer(contractBalance);//send the remaining balance 
        //msg.value is the attached value to the contract.
        //msg.sender is the triggering value.
    }
}