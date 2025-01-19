// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

/**
 * @title Vulnerable Contract (Example of Reentrancy Vulnerability)
 * @author Trev
 * @notice This contract intentionally contains a reentrancy vulnerability.
 * @dev The withdraw function is vulnerable because it interacts with an external address before updating the state,
 *      allowing reentrancy attacks.
 */
contract Vulnerable {
    // Mapping to store the balances of users
    mapping(address => uint256) private s_balances;

    /**
     * @notice Allows users to deposit ether into the contract
     * @dev This function adds the sent ether to the user's balance.
     * @dev No protection is in place to prevent reentrancy attacks.
     */
    function deposit() public payable {
        require(msg.value > 0, "Deposit must be greater than zero.");
        s_balances[msg.sender] += msg.value;
    }

    /**
     * @notice Allows users to withdraw ether from the contract.
     * @dev Vulnerable to reentrancy attacks because the external call is made before updating the user's balance.
     *      The attacker can call this function recursively to withdraw more ether than they initially deposited.
     */
    function withdraw() public {
        uint256 amount = s_balances[msg.sender];
        require(amount > 0, "Insufficient balance.");

        // External call before state update (vulnerable pattern)
        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Withdrawal failed.");

        // State update is done after the external call, which makes this vulnerable to reentrancy
        s_balances[msg.sender] = 0;
    }
}
