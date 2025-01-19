# Solidity Reentrancy Attack Demo

This repository demonstrates a **reentrancy vulnerability** in Solidity smart contracts, along with an **attack contract** that exploits this vulnerability.

## Overview

1. **Vulnerable Contract**: A basic Solidity contract with a common reentrancy vulnerability in its `withdraw()` function. This allows an attacker to recursively withdraw more funds than they deposited.
2. **Attacker Contract**: A contract that exploits the vulnerability by calling the `withdraw()` function recursively via a fallback function, draining the vulnerable contract's balance.
3. **Secure Contract**: A secure version of the contract that fixes the vulnerability by following the **Checks-Effects-Interactions** pattern, preventing reentrancy attacks.

## Purpose

This project serves as an educational tool to:
- Demonstrate how **easily** reentrancy vulnerabilities can occur in Solidity.
- Show how such vulnerabilities can be **exploited** by attackers.
- Provide a **solution** using best practices like **Checks-Effects-Interactions** to avoid common pitfalls in smart contract security.

## Files

- `Vulnerable.sol`: The vulnerable contract with the reentrancy bug.
- `Attacker.sol`: The attacker contract that exploits the vulnerability.
- `SecureVulnerable.sol`: The fixed version of the vulnerable contract using the Checks-Effects-Interactions pattern.

## Learn More

To learn more about reentrancy attacks and best practices for writing secure Solidity contracts, visit the following resources:
- [Solidity Documentation - Security Considerations](https://docs.soliditylang.org/en/v0.8.10/security-considerations.html)
- [Reentrancy Attacks - ConsenSys](https://scsfg.io/hackers/reentrancy/#single-function-reentrancy)
