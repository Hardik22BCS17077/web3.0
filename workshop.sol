// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecretSanta {
    address public organizer;
    address[] public participants;
    mapping(address => address) public assignedSanta;
    bool public assignmentDone;
    
    event ParticipantRegistered(address participant);
    event AssignmentsCompleted();
    event GiftReceived(address santa, address recipient);

    modifier onlyOrganizer() {
        require(msg.sender == organizer, "Only organizer can perform this action");
        _;
    }
    
    modifier beforeAssignment() {
        require(!assignmentDone, "Assignments already done");
        _;
    }
    
    constructor() {
        organizer = msg.sender;
    }

    function register() external beforeAssignment {
        require(!isRegistered(msg.sender), "Already registered");
        participants.push(msg.sender);
        emit ParticipantRegistered(msg.sender);
    }

    function isRegistered(address _participant) public view returns (bool) {
        for (uint i = 0; i < participants.length; i++) {
            if (participants[i] == _participant) {
                return true;
            }
        }
        return false;
    }

    function assignSecretSantas() external onlyOrganizer beforeAssignment {
        require(participants.length >= 2, "Not enough participants");
        
        address[] memory tempList = new address[](participants.length);
        for (uint i = 0; i < participants.length; i++) {
            tempList[i] = participants[i];
        }
        
        for (uint i = 0; i < participants.length; i++) {
            uint randomIndex = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, i))) % tempList.length;
            
            // Ensure no one gets themselves
            if (tempList[randomIndex] == participants[i]) {
                randomIndex = (randomIndex + 1) % tempList.length;
            }
            
            assignedSanta[participants[i]] = tempList[randomIndex];
            tempList[randomIndex] = tempList[tempList.length - 1];
            tempList[tempList.length - 1] = address(0);
        }
        
        assignmentDone = true;
        emit AssignmentsCompleted();
    }

    function confirmGiftReceived() external {
        require(assignmentDone, "Assignments not done yet");
        require(assignedSanta[msg.sender] != address(0), "You are not assigned a Santa");
        emit GiftReceived(assignedSanta[msg.sender], msg.sender);
    }
    
    function getAssignedSanta(address _participant) external view returns (address) {
        require(assignmentDone, "Assignments not yet done");
        return assignedSanta[_participant];
    }
}
