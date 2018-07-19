pragma solidity ^0.4.21;

//This is the contract that will be unchangeable once deployed. It will call delegate functions in another contract to change state.  The delegate contract is upgradable.

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';
import 'zeppelin-solidity/contracts/token/BurnableToken.sol';

contract RiobitToken is BurnableToken{
    unit public INITIAL_SUPPLY = 1000000;
    string public name = 'RioBitToken';
    string public symbol = 'RBT';
    uint8 public decimals = 8;
    address public owner;
    bool public released = false;

    function RioBitToken() public {
        totalSupply_ = INITIAL_SUPPLY //* 10 ** uint(decimals);  //total tokens
        owner = msg.sender;
        balances[owner] = INITIAL_SUPPLY;  //owner have total tokens at first    
    }


    function release() public {
        require(owner == msg.sender);
        require(!released);
        released =true;
    }

    modifier onlyReleased() {
        require(released);
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function burn(uint256 value) public onlyOwner {
        //Call BurnableToken.burn(value);
        super.burn(value);
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

