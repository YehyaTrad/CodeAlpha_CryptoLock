# Crypto Lock Smart Contract
**CodeAlpha Blockchain Development Internship – Task 4**

## 📌 Project Overview
This project is a personal portfolio smart contract written in **Solidity** as part of the **CodeAlpha Blockchain Development Internship**.

The smart contract demonstrates how to:
- Deposit Ether (ETH) into a smart contract
- Set a lock-in period for the deposit
- Withdraw Ether only after the lock time expires
- Prevent early withdrawals securely

---

## 🛠️ Technologies Used
- **Solidity (v0.8.x)**
- **Remix IDE**
- **Ethereum Virtual Machine (Remix VM)**

---

## 📄 Smart Contract Features
- `deposit(uint256 _lockTimeInSeconds)` function allows users to deposit Ether with a lock period
- `withdraw()` function allows users to withdraw Ether only after the lock expires
- `balances` mapping stores deposited amount per address
- `unlockTime` mapping stores unlock time per address
- Uses `block.timestamp` to enforce time-lock securely
- Successfully compiled, deployed, and tested in Remix IDE

---

## 📜 Smart Contract Code

```solidity
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
