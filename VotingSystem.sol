// VotingSystem.sol
pragma solidity ^0.8.19;

contract VotingSystem {
    address public admin;
    mapping(address => bool) public voters;
    mapping(bytes32 =>uint256) public votes;
    bool public votingOpen;

    
}