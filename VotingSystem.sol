pragma solidity ^0.8.19;

/**
 * A smart contract for a secure voting system. Modifiers for admin, registered voters, and voting windows.
 */
contract VotingSystem {
    address public admin;
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votes; //32 bytes are required to store an int of uint256 type
    bool public votingOpen; //stores whether voting is open or closed
    
    // Events logs are stored on the blockchain once emitted.
    event VoterRegistered(address indexed voter);
    event VoteCast(address indexed voter, bytes32 indexed candidate);
    event VotingClosed();

    /**
     * Modifier: Only enables admins to call the function
     */
    modifier onlyAdmin() {
      require(msg.sender == admin, "Only admin can call this function");
      _; //Used to execute function
    }

    /**
     * Modifier: Only registered voters can call this function
     */
    modifier onlyVoter() {
      require(voters[msg.sender], "Only a registered voter can call this function");
      _;
    }

    /**
     * Modifier: Function can only be called when voting is open.
     */
    modifier votingIsOpen() {
      require(votingOpen, "Voting window is over.");
      _;
    }

    /**
     * Initialize contract, developer is set to admin and voting is set to open.
     */
    constructor() {
      admin = msg.sender;
      votingOpen = true;
    }

    /**
     * Admin can register voters.
     * Voter address is registered.
     */
    function registerVoter(address _voter) external onlyAdmin {
      require(!voters[_voter], "Voter already registered"); //prevent previously registered voters from voting again.
      voters[_voter] = true;
      emit VoterRegistered(_voter);
    }

    /**
     * Allow admin to open voting by setting the boolean votingOpen variable to true.
     */
    function openVoting() external onlyAdmin {
      votingOpen = true;      
    }

    /**
     * Allow admin to close voting by setting the boolean votingOpen variable to false.
     */
    function closeVoting();() external onlyAdmin {
      votingOpen = false;
      emit VotingClosed();
    }

    /**
     * Allows only registered voters to cast a vote and only when voting is open and only for candidates.
     * _candidate: The unique identifier of the candidate, _candidate is a function argument.
     */
    function castVote(bytes32 _candidate) external onlyVoter votingIsOpen {
      require(votes[_candidate] < type(uint256).max, "Vote count overflow");
      votes[_candidate]++; //increment vote for chosen candidate
      emit VoteCast(msg.sender, _candidate);
    }
}