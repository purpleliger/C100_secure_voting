pragma solidity ^0.8.19;

/**
 * A smart contract for a secure voting system. Modifiers for admin, registered voters, and voting windows.
 */
contract VotingSystem {
    address public admin;
    mapping(address => bool) public voters;
    mapping(bytes32 =>uint256) public votes;
    bool public votingOpen; //stores whether voting is open or closed

    event VoterRegistered(address indexed voter);
    event VOteCast(address indexed voter, bytes32 indexed candidate);
    event VotingClosed();

    /**
     * Modifier: Only enables admins to call the function
     */
     modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
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

        



}