17 jan
---------
1. proof of work
2. proof of stack
3. bitcoin mining

18 jan
-------
smart contact

code:
---------------------------------
pragma solidity ^0.4.17;

contract Inbox{
    string public message;
    
    function Inbox(string initialMessage) public{
        message = initialMessage;
    }
    
    function setMessage(string newMessage) public{
        message = newMessage;
    }
    
/*    function getMessage() public view returns (string){
        return message;
    }*/
}
----------------------------------
