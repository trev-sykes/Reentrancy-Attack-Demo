// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

/**
 * @title Secure Vulnerable Contract (with Checks-Effects-Interactions)
 * @author Trev
 * @notice This contract follows the Checks-Effects-Interactions pattern to avoid reentrancy attacks.
 * @dev The withdraw function is now secure because it updates the state (balance) before making external calls.
 */
contract SecureVulnerable {
    // Mapping to store the balances of users
    mapping(address => uint256) private s_balances;

    /**
     * @notice Allows users to deposit ether into the contract.
     * @dev This function adds the sent ether to the user's balance.
     *      No reentrancy issue as state is updated before the external call.
     */
    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than zero.");
        s_balances[msg.sender] += msg.value;
    }

    /**
     * @notice Allows users to withdraw ether from the contract.
     * @dev The function first updates the user's balance, then makes the external call to transfer ether.
     *      This avoids reentrancy by ensuring state changes occur before external calls.
     */
    function withdraw() public {
        uint256 amount = s_balances[msg.sender];
        require(amount > 0, "Insufficient balance.");

        // Checks: User has a sufficient balance
        // Effects: Update the state (balance is set to 0 before external call)
        s_balances[msg.sender] = 0;

        // Interactions: Transfer ether to the user
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed.");
    }
}
