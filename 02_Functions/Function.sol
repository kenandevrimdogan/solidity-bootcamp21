//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Functions {
    
    uint luckyNumber = 7;
    uint public x = 3;

    function showNumber() public view returns(uint){
        return luckyNumber;
    } 

    function setNumber(uint newNumber) public {
        luckyNumber = newNumber;
    }

    function nothing() public pure returns(uint, bool, bool){
        return (1, true, false);
    }

    function setX(uint newX) public {
        x = newX;
    }

    function  add(uint a, uint b) public view returns(uint) {
        return a + b + block.timestamp;
    }       

    function add2(uint a, uint b) public pure returns(uint){
        return a + b;
    }

    // public, external, internal, private

    // public: Hem dışarıdan çağırabilir, hem de kontratlar.
    function pA(uint a, uint b) public pure returns(uint){
        return a + b;
    }

    function pB(uint c, uint d) public pure returns(uint){
        return pA(c, d);
    }

    // private: Dışarıdan çağrılamaz, sadece bulunduğu kontratdan erişebilinir
    function pC() private pure returns (string memory){
        return "Bu bir private fonksiyondur";
    }

    // internal: Kontratı miras alabilen kontrat kullanabilir

    function iA() internal pure returns(string memory){
        return "";
    }

    // external: Dışarıdan çağrınabilinir fakat kontrat içerisinde çağrılmaz

    function eA() external pure returns(string memory){
        return "";
    }
}