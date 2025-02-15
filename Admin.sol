// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./IBank.sol";

contract Admin {
    address public owner; // 定义一个地址类型的公共变量 owner

    constructor() {
        owner = msg.sender; // 在构造函数中初始化 owner
    }

    /// 调用者未被授权进行此操作。
    error Unauthorized();

    function adminWithdraw(IBank bank) public {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        require(address(bank) != address(0), "Invalid bank address"); // 确保地址有效
        bank.withdraw(address(bank).balance);
    }
}