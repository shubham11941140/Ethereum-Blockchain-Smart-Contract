// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";

contract Digital_Asset_Transfer_via_Auction
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    function makeNFT()
    private
    returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();

        return newItemId;
    }

    struct Nft
    {
        address owner;
        address artist;
        string art;
        uint256 token;
    }

    Nft nft;
    address public auctionHost;
    uint256 public closetime;
    address public topBidder;
    uint256 public topBid;
    bool auctionComplete;
    bool auctionRunning;
    uint256 lowest_bid;

    // start auction
    constructor (address nftArtist, string memory art)
    {
        nft.owner = msg.sender;
        nft.art = art;
        nft.artist = nftArtist;
        nft.token = makeNFT();
    }

    function startAuction(uint256 _biddingTime)
    public
    payable
    {
        require(msg.sender == nft.owner);
        topBidder = address(0x0);
        topBid = 0;
        auctionRunning = true;
        auctionComplete = false;
        closetime = block.timestamp + _biddingTime;
        auctionHost = msg.sender;
        lowest_bid = 1;
    }

    function bid()
    public
    payable
    {
        require(block.timestamp <= closetime);
        require(msg.value > topBid);
        require(msg.value > lowest_bid);
        require(auctionRunning == true);
        require(msg.sender != address(0x0));
        require(!auctionComplete);

        // refund
        if(topBid != 0)
        {
            payable(topBidder).transfer(topBid);
        }

        topBid = msg.value;
        topBidder = msg.sender;
    }

    function auctionClose()
    public
    payable
    {
        // 1. Conditions
        require(block.timestamp >= closetime);

        // auction did not yet end
        require(!auctionComplete);

        // this function has already been called
        require(auctionRunning);

        require(topBid > lowest_bid);
        require(topBidder != address(0x0));

        // 2. Effects
        auctionComplete = true;
        auctionRunning = false;

        // 3. Interaction

        uint256 royalty = topBid / 20;
        payable(nft.artist).transfer(royalty);
        payable(auctionHost).transfer(topBid - royalty);

        // 4. NFT Transfer
        nft.owner = topBidder;
    }
}