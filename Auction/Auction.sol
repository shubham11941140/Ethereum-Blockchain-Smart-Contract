// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract simpleAuction
{
    // Auction parameters. Times are either
    // in the format of unix timestamps (seconds that have passed since 1970-01-01)
    // or a time period in seconds.
    address public beneficiaryAddress;
    uint256 public closetime;

    // Current state of the auction.
    address public topBidder;
    uint256 public topBid;

    uint256 public lowest_bid = 1; // 1 eth lowest bid

    // Will be set true once the auction is complete, preventing any further change
    bool auctionComplete;

    // Events to fire when change happens.
    event topBidIncreased(address bidder, uint256 bidAmount);
    event auctionResult(address winner, uint256 bidAmount);

    /// Create an auction with `_biddingTime`
    /// seconds for bidding on behalf of the
    /// beneficiary address `_beneficiary`.
    function SimpleAuction (uint256 _biddingTime, address _beneficiary)
    public
    {
        beneficiaryAddress = _beneficiary;
        closetime = block.timestamp + _biddingTime;
    }

    /// You may bid on the auction with the value sent
    /// along with this transaction.
    /// The value may only be refunded if the
    /// auction was not won.
    function bid()
    public
    payable
    {
        // No argument is necessary, all
        // information is already added to
        // the transaction. The keyword payable
        // is required so the function
        // receives Ether.

        // Check if the address of the bidder is valid
        require(topBidder != address(0));

        // Revert the call in case the bidding
        // period is over.
        require(block.timestamp <= closetime);

        // If the bid is not greater,
        // the money is sent back.
        require(topBid > lowest_bid);
        require(msg.value > topBid);

        topBidder = msg.sender;
        topBid = msg.value;
        emit topBidIncreased(msg.sender, msg.value);
    }

    /// Auction ends and highest bid is sent
    /// to the beneficiary.
    function auctionClose()
    public
    {
        // It is a good practice to structure functions which interact
        // with other contracts (i.e. call functions or send Ether)
        // into three phases:
        // 1. check conditions
        // 2. perform actions (potentially change conditions)
        // 3. interact with other contracts

        // 1. Conditions
        require(block.timestamp >= closetime); // auction did not yet end
        require(!auctionComplete); // this function has already been called

        // 2. Effects
        auctionComplete = true;
        emit auctionResult(topBidder, topBid);

        // 3. Interaction
        payable(beneficiaryAddress).transfer(topBid);
    }
}