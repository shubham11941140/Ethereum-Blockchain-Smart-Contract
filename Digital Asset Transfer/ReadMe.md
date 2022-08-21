## Project Problem Statement Description:

### How to sell (and resell) a digital asset using smart contracts?

1. Twitter Post
2. Facebook Post
3. A Digital Art (which resides on the Internet)

### Each time the digital asset changes ownership, the artist gets some percentage of the cost as royalty.

## Project Implementation Details:

Report file contains the Core Idea followed by an Implementation using smart contract.

We implement the digital asset transfer by breaking it into multiple phases where we generate the NFT using Library Implementation for our digital asset. This is followed by hosting an auction where prospective bidders can submit their bids.

After all the bids are submitted and the bidding time is complete, the auction is closed, followed by the transfer of the Ethereum from the Auction winner to the Beneficiary.

In simple words, we auction digital assets and transfer them by changing the ownerships of NFTs in the Ethereum Blockchain.

Demo file contains a video demonstration of the live project on Remix IDE

This can be extended to deployment on the Ropsten Test Network via Metamask as well.

## Live Project Deployed at:

### Remix IDE Deployment:

### http://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.10+commit.fc410830.js

### Ropsten Test Network (Etherscan via MetaMask):

### https://ropsten.etherscan.io/address/0x5374761798a80859dd5351cb75b3e4595acc4680

## References:

### _General_

#### NFT - https://en.wikipedia.org/wiki/Non-fungible_token

#### Remix IDE - http://remix.ethereum.org/ : Sandbox - Javascript (London)

### _Library_

#### _OpenZepellin_ Contract library on GitHub – https://openzeppelin.com/contracts

### _Code File_

#### _Counters.sol_ – https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol
