pragma solidity ^0.4.2;

/****************************************************************************************/
/*   Author   : Mehdi TAZI                                                              */
/*   Website  : tazimehdi.com                                                           */
/*   Source   : https://github.com/MehdiTAZI/EthereumBlockchainToken                    */
/*                                                                                      */
/* the SimpleChat contract inherite from UserCustomizable that inherite from Ownable.   */
/* which allows the SimpleChat contract to be capable of                                */
/*          having some admin capabilities, and transfering it to another address.      */
/*          matching addresses with usernames                                           */
/****************************************************************************************/

import "./UserCustomizable.sol";

/*
    TODO :
    MehdiTAZIToken token;
    use MehdiTAZIToken to pay chat transaction every 100 msg;
*/

contract SimpleChat is UserCustomizable {

    /* basic Message Structure */
    struct Message {
        address from;
        string content;
    }

    /* list of messages per user */
    mapping (address => Message[]) internal messages;
    /* last index of unread messages per user */
    mapping (address => uint256) internal lastUnreadMessageIndex;

    /* occures when message is sent */
    event MessageSent(address from,address to, string message);

    /* useful functions */
    function compareStrings (string a, string b) internal pure returns (bool){
        return keccak256(a) == keccak256(b);
    }

    /* constructor */
    function SimpleChat() public {
        Message memory genesisMessage = Message({from:0x0, content:"Hello World : Genesis Message !"});
        messages[0x0].push(genesisMessage);
    }

    /* FUNCTION : SEND MESSAGE */

    /* internal logical sending message function */
    function _sendMessage(address _src, address _target, string _message) internal  {
        require (!compareStrings(_message,""));

        Message memory newMessage = Message({from:_src, content:_message});
        messages[_target].push(newMessage);
        MessageSent(msg.sender,_target,_message);
    }

    function sendMessage(address target, string message) public  {
        _sendMessage(msg.sender, target, message);
    }

    function sendMessage(address src, address target, string message) onlyOwner public  {
        _sendMessage(src, target, message);
    }

    /* FUNCTION : RECIEVING MESSAGE */

    /* internal logical receiving message function */
    function _getMessageAt(address _from, uint256 _messageIndex) internal view returns(address, string) {
        uint256 messagesLength  = messages[_from].length;
        if(_messageIndex >= 0 && _messageIndex < messagesLength ){
            Message memory message = messages[msg.sender][_messageIndex];
            return (message.from ,message.content);
        }
        return (0x0 ,"ERROR");
    }

    function getMessageAt(address from, uint256 messageIndex) onlyOwner public view returns(address, string) {
        return getMessageAt(from, messageIndex);
    }

    /* read message from at position messageIndex */
    function getMessageAt(uint256 messageIndex) public view returns(address, string) {
        return _getMessageAt(msg.sender, messageIndex);
    }

    /* read last unread message function */
    function getLastUnreadMessage() public returns(address, string) {
        uint256 messageIndex = lastUnreadMessageIndex[msg.sender];

        uint256 messagesLength = messages[msg.sender].length;
        if(messageIndex >= 0 && messageIndex < messagesLength){
            lastUnreadMessageIndex[msg.sender] +=1;
        }
        return getMessageAt(messageIndex);
    }

}