pragma solidity ^0.4.21;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract RiobitToken is StandardToken{
    unit public INITIAL_SUPPLY = 1000000;
    string public name = 'RioBitToken';
    string public symbol = 'RBT';
    uint8 public decimals = 8;
    address owner;

    function RioBitToken() public {
    totalSupply_ = INITIAL_SUPPLY * 10 ** uint(decimals);  //total tokens
    balances[msg.sender] = INITIAL_SUPPLY;  //owner have total tokens at first
    owner = msg.sender;
    }

    bool public released = false;

    function release() public {
        require(owner == msg.sender);
        require(!released);
        released =true;
    }

    modifier onlyReleased() {
        require(released);
        _;
    }

    //when crowdfunding is finished, the transfer of coin is possible.
    function transfer(address to, uint256 value) public onlyReleased returns (bool) {
        super.transfer(to, value);
    }
    //when crowdfunding is finished, the operation of coin is possible.
    function allowance(address owner, address spender) public onlyReleased view returns (uint256) {
        super.allowance(owner,spender);
    }

    function transferFrom(address from, address to, uint256 value) public onlyReleased returns (bool) {
        super.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value) public onlyReleased returns (bool) {
        super.approve(spender,value);
    }
}

