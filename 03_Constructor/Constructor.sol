//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Constructor {
    string public tokenName;
    uint public totalSupply;

    // constant: değer değiştirilemez. Başlangıçta değer vermek gerekir.
    uint public constant number2 = 10;
    
    // immutable: değer değiştirilemez. Constructor değer vermek gerekir.

    uint public immutable inumber;

    constructor(string memory name, uint number){
        tokenName = name;
        totalSupply = number;
        inumber = 2;
    }

    function set(uint number) public {
        totalSupply = number;
    }
}