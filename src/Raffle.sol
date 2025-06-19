// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// internal & private view & pure functions
// external & public view & pure functions

//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

/**
 * @title A sample raffle contract
 * @author Jesus Valencia
 * @notice This contract is for creating a sample raffle
 * @dev This implements the Chainlink VRF Version 2.5
 */

contract Raffle {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle(); //contract__error

    /* Type declarations */
    uint256 private immutable i_entranceFee;
    // @dev The interval at which the raffle will automatically pick a winner in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    //Events
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH to enter raffle!");
        //require(msg.value >= i_entranceFee, SendMoreToEnterRaffle()); for solidity 0.8.26 and later for specific compiler version
        if (msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    //1. Get a random number
    //2. Pick a winner
    //3. Be Automatically called
    function pickWinner() external {
        //check to see if enough time has passed
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
    }

    //Getter functions
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
