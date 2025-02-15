// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./Bank.sol";

contract BigBank is Bank {

    uint minAmount = 0.001 ether;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


    modifier requireMinimum(uint _amount) {
        require(_amount >= minAmount, "Minimum deposit is 0.001 ETH");
        _;
    }

    modifier onlyOwner(address _address) {
        require(_address == owner, "Only owner can call this function");
        _;
    }

    // 新的函数来处理接收的逻辑，并应用 requireMinimum 修饰符
    function deposit() internal requireMinimum(msg.value) {
        balances[msg.sender] += msg.value;
        updateRanking(msg.sender, balances[msg.sender]);
        emit Received(msg.sender, msg.value);
    }

    // 重写 receive 函数，调用新的 deposit 函数
    receive() external payable override{
        deposit();
    }

    function tranferOwnership(address _newOwner) public onlyOwner(msg.sender) {
        require(_newOwner != address(0), "New owner cannot be zero address");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }
}