# Ethereum-Dutch-Auction
a. The seller instantiates a DutchAuction contract to manage the auction of a single, physical item at a
single auction event. The contract is initialized with the following parameters:
i. reservePrice: the minimum amount of wei that the seller is willing to accept for the item
ii. numBlocksAuctionOpen: the number of blockchain blocks that the auction is open for
iii. offerPriceDecrement: the amount of wei that the auction price should decrease by during each
subsequent block.
iv. judgeAddress: used by another part in this assignment.
b. The seller is the owner of the contract.
c. The auction begins at the block in which the contract is created.
d. The initial price of the item is derived from reservePrice, numBlocksAuctionOpen, and
offerPriceDecrement: initialPrice = reservePrice + numBlocksAuctionOpen*offerPriceDecrement
e. A bid can be submitted by any Ethereum externally-owned account.
f. The first bid processed by the contract that sends wei greater than or equal to the current price is the
winner. The wei should be transferred immediately to the sender and the contract should not accept
any more bids. All bids besides the winning bid should be refunded immediately.
