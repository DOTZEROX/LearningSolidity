// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
// import "@openzeppelin/contracts/utils/structs/BitMaps.sol";


// @title  
// 1. A new smart contract to create ERC20 tokens. This contract distributes ERC20 tokens
// to eligible ERC1155 token owners.
// The Avatar will look like this:
//{
//    tokeId: 'ID number01',

//    tokeId: 'ID number02',
//    Contract address: "0x1234...1234,
//    Amount : [amount 02]
//}//    Contract address: "0x1234...1234,
//    Amount : [amount of tokens]
//}

// A mapping (address -> Avatar) public avatars;
//{
//    tokeId: 'ID number01',
//    Contract address: "0x1234...1234,
//    Amount : [amount 01]
//
contract FRNSToken is ERC20, ERC20Permit, ERC20Votes, Ownable {
    // Declare state variables of the contract
    // Create the avatar structure to assign the tokens
    //ERC1155 token ID;
    //Contract address;
    
    struct Avatar {
    uint256 tokeId;
    address wrapper;
    } 

    // Create Distribution Plan 
    uint256 [] public amounts;
    
// 2.2 mapping (Struct []=> amount) 

    mapping ( Avatar => uint256) AvatarAmount;
// 3. A storage structure to store information about claimed tokens
//  mapping ((Struct []=> amount) => bool) // all values by default set to false
// 
// 4. A distribution function to allow eligible owners to claim their tokens
// 4.1 When tokens claimed => update mapping
// 


    

   
   

    
  

    /**
     * @dev Constructor.
     * @param freeSupply The number of tokens to issue to the contract deployer.
     * @param airdropSupply The number of tokens to reserve in this contract for distribution
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
}

// https://ethereum.stackexchange.com/questions/2385/can-i-save-structs-in-a-mapping/2386
