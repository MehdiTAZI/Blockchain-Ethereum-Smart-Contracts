pragma solidity ^0.4.2;

/************************************************************************/
/*   Author   : Mehdi TAZI                                              */
/*   Website  : tazimehdi.com                                           */
/*   Source   : https://github.com/MehdiTAZI/EthereumBlockchainToken    */
/************************************************************************/

contract Ownable {

    /* owner adress */
    address public owner;


    function Ownable() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    /* only the owner have the ability to transfer it ownership */
    function transferOwnership(address newOwner) onlyOwner public {
        owner = newOwner;
    }
}