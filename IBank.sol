// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;


interface IBank {
    event Received(address from, uint amount);
    function withdraw(uint amount) external;
    function getTopThreeUserAddressInfo(uint idx) external view returns (address);
}