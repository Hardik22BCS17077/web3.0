# Secret Santa Smart Contract

## Overview
This is a **Secret Santa** smart contract built in Solidity that allows participants to register, get assigned a random Secret Santa, and confirm gift receipt in a fair and decentralized manner.

## Features
- **Registration:** Users can register to participate in the Secret Santa event.
- **Random Assignment:** The contract assigns each participant a Secret Santa randomly.
- **Gift Confirmation:** Participants can confirm receipt of their gift.
- **Organizer Control:** Only the contract organizer can finalize the assignments.

## Prerequisites
- Node.js and npm installed
- Hardhat or Foundry for local blockchain testing
- MetaMask or any Web3-compatible wallet

## Deployment Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/secret-santa.git
   cd secret-santa
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Compile the contract:
   ```bash
   npx hardhat compile
   ```
4. Deploy the contract:
   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```

## Smart Contract Functions
### 1. `register()`
Registers a participant for the Secret Santa event.
```solidity
function register() external beforeAssignment;
```

### 2. `assignSecretSantas()`
Assigns each participant a Secret Santa randomly. Only the organizer can call this function.
```solidity
function assignSecretSantas() external onlyOrganizer beforeAssignment;
```

### 3. `confirmGiftReceived()`
Allows a participant to confirm receipt of a gift.
```solidity
function confirmGiftReceived() external;
```

### 4. `getAssignedSanta(address _participant)`
Returns the Secret Santa assigned to a specific participant.
```solidity
function getAssignedSanta(address _participant) external view returns (address);
```

## Testing
Run the test cases using Hardhat:
```bash
npx hardhat test
```

## License
This project is licensed under the MIT License.

## CONTRACT ADDRESS : 0xb2A64C6B26Ff21b8D01BC74a8854bB6AFC3FD56A 
