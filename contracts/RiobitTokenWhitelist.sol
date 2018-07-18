pragma solidity ^0.4.21;

contract RioBitTokenWhitelist {
    address owner;
    function RioBitTokenWhitelist() public{
        owner = msg.sender;
    }

    mapping(byte32 => bool) whitelist;
    
}