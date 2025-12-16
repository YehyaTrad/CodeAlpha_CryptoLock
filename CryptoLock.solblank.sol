// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoLock {

    // Store deposited ETH balance of each user
    mapping(address => uint256) public balances;

    // Store unlock time for each user
    mapping(address => uint256) public unlockTime;

    // Deposit ETH with lock time (in seconds)
    function deposit(uint256 _lockTimeInSeconds) public payable {
        require(msg.value > 0, "Please send some Ether");

        balances[msg.sender] += msg.value;
        unlockTime[msg.sender] = block.timestamp + _lockTimeInSeconds;
    }

    // Withdraw ETH after lock time
    function withdraw() public {
        require(balances[msg.sender] > 0, "No funds to withdraw");
        require(block.timestamp >= unlockTime[msg.sender], "Funds are still locked");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }
}
