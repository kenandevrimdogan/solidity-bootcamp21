//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Bank {
    
    mapping(address => uint) balances;

    function sendEtherToContract() payable external { 
        balances[msg.sender] = msg.value;
    }

    function showBalance() external view returns(uint){
        return balances[msg.sender];
    }

    function withdraw(address payable to, uint amount) external returns(bool){
        require(balances[msg.sender] >= amount, "Not enough");
        //  payable(msg.sender).transfer(balances[to]);
        // bool ok = to.send(amount)
        // (bool sent, bytes memory data) = to.call{value: amount}("");
        (bool sent,) = to.call{value: amount}("");
         balances[msg.sender] -= amount;

         return sent;
    }

    uint public receiveCount = 0;
    uint public fallbackCount = 0;
    receive() external payable{ // transaction işleminde çalışır
        receiveCount++;
    }

    fallback() external payable{ // transaciton işlemi çalıştırırken callData gönderiliyorsa çalışılır
        fallbackCount++;
    }
}