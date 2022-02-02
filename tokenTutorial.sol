// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./MerkleProof.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";


// @title  
// 1. A new smart contract to create ERC20 tokens
// 2. A distribution plan structure to associate ERC1155 token-ID to ERC20 token amount
// 2.1 Introducing a Struct {
//    ERC1155 token ID
//    Contract address
// } 
// 2.2 mapping (Struct []=> amount) 
// 3. A storage structure to store information about claimed tokens
//  mapping ((Struct []=> amount) => bool) // all values by default set to false
// 
// 4. A distribution function to allow eligible owners to claim their tokens
// 4.1 When tokens claimed => update mapping
// 

contract FRNSToken is ERC20, ERC20Permit, ERC20Votes, Ownable {
    

    uint256 public constant minimumMintInterval = 365 days;
    uint256 public constant mintCap = 200; // 2%

 
    uint256 public nextMint; // Timestamp
    uint256 public claimPeriodEnds; // Timestamp
   

    
  

    /**
     * @dev Constructor.
     * @param freeSupply The number of tokens to issue to the contract deployer.
     * @param airdropSupply The number of tokens to reserve for the airdrop.
     * @param _claimPeriodEnds The timestamp at which tokens are no longer claimable.
     */
    constructor(
        uint256 freeSupply,
        uint256 airdropSupply,
        uint256 _claimPeriodEnds
    )
        ERC20("FRNS CARDS", "FRNS")
        ERC20Permit("FRNS CARDS")
    {
        _mint(msg.sender, freeSupply);
        _mint(address(this), airdropSupply);
        claimPeriodEnds = _claimPeriodEnds;
        nextMint = block.timestamp + minimumMintInterval;
    }
