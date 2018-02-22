pragma solidity ^0.4.2;

/************************************************************************/
/*   Author   : Mehdi TAZI                                              */
/*   Website  : tazimehdi.com                                           */
/*   Source   : https://github.com/MehdiTAZI/EthereumBlockchainToken    */
/************************************************************************/

import "./Ownable.sol";

contract UserCustomizable is Ownable {

    /* matching addresses and usersname */
    mapping (address => string) internal usersName;

    function UserCustomizable() public {

    }
    /* internal setter function */
    function _setUserName(address _user, string _userName) internal {
        usersName[_user] = _userName;
    }

    /* setter function */
    function setUserName(address user, string userName) onlyOwner public {
        _setUserName(user, userName);
    }

    /* setter function */
    function setUserName(string userName) public {
        _setUserName(msg.sender, userName);
    }

    /* internal getter function */
    function _getUserName(address _useraddr) internal view returns(string){
        return usersName[_useraddr];
    }

    /* getter function */
    function getUserName(address useraddr) onlyOwner public view returns(string){
        return _getUserName(useraddr);
    }

    /* getter function */
    function getUserName() public view returns(string){
        return _getUserName(msg.sender);
    }
}