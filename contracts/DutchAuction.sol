pragma solidity ^0.4.9;

contract DutchAuction {

    uint256 initialPrice;
    uint256 createBlockNum;
	uint256 offerPriceDecrement;
    uint256 reservePrice;
    uint256 numBlocksAuctionOpen;
	address judgeAddress;
    address public winnerAddress;
    address public sellerAddress;
    bool private hasfirstbidder = false;
    bool private hassecondbidder = false;
    bool private hasReceiveItem = false;
    bool private hasFinalized = false;
    bool private hasBidded = false;
    uint gid = 0;
    

    
    function DutchAuction(uint256 _reservePrice, address _judgeAddress, uint256 _numBlocksAuctionOpen, uint256 _offerPriceDecrement) public {
        sellerAddress = msg.sender;
        reservePrice = _reservePrice;
        offerPriceDecrement = _offerPriceDecrement;
        numBlocksAuctionOpen = _numBlocksAuctionOpen;
        createBlockNum = block.number;
        judgeAddress = _judgeAddress;
        


    }

    function bid() public payable returns(address) {
        
        require(msg.value > reservePrice); 
        require((block.number - createBlockNum) < numBlocksAuctionOpen);
        initialPrice = reservePrice + numBlocksAuctionOpen*offerPriceDecrement;
        sellerAddress.transfer(msg.value);
        hasfirstbidder = true;
        gid = gid + 1;
        if (gid > 1){
            hassecondbidder = true;
        }
        winnerAddress = msg.sender;
        hasBidded = true;

        return msg.sender;  
        
        
    }

    function finalize() public {
        require(hasfirstbidder);
        require(!hassecondbidder);
        require(!hasFinalized);
        //if (msg.sender != winnerAddress || msg.sender != judgeAddress) require(false);
        
        if(msg.sender == winnerAddress) {
            //require(!hasReceiveItem);
            //if(gid != 1) require(false);   
            finalizeStatus();                                        
        }
        else if(msg.sender == judgeAddress) {
            finalizeStatus();
        }
        else {
            require(!hasBidded); 
                       
            refund(sellerAddress.balance);
            hasFinalized = true;            
        }
        

        

    }

    function refund(uint256 refundAmount) public {
        
        
        
        msg.sender.transfer(msg.value);
        
    }

    function finalizeStatus() public {
        hasReceiveItem = true; 
        hasFinalized = true;
    }

    
	

    //for testing framework
    function nop() public returns(bool) {
        return true;
    }
}



