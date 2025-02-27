// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract test{

    string message = "hello world";

    function helloworld() public view returns (string memory){
        return message;
    }


    uint a = 8; 
    uint b = 4;
    uint public c = 3;

    function add() public view returns(uint){
        return a+b;
    }

    function sub() public view returns(uint){
        return a-b;
    }

    function mul() public view returns(uint){
        return a*b;
    }

    function div() public view returns(uint){
        return a/b;
    }

    function increment() public returns(uint){
        return c++; 
    }

    function decrement() public returns(uint){
        return c--;
    }

    bool toggle = false;
    function check() public returns (bool){
        if (toggle) {
            toggle = false;
        }else{
            toggle=true;
        }
        return toggle;
    }

    function numbers(int num) public pure returns (string memory) {
        if(num % 2 == 0) {
            return "Even";
        } else {
            return "Odd";
        }
    }

    function concat(string memory str1, string memory str2) pure public returns(string memory){
        return string(abi.encodePacked(str1,str2));
    }

    // function concatHelloWorld() public pure returns (string memory) {
    //     return string(abi.encodePacked("hello", "world"));
    // }

    function isEven(int num) public pure returns(int){
        require(num > 0, "The number is less than zero.");
        num++;
        return num;
    }
}