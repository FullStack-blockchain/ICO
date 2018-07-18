pragma solidity ^0.4.21;

import './RiobitToken.sol';
import './RiobitTokenWhitelist.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';

contract RiobitTokenSale {
    using SafeMath for uint256;
    uint public constant EMMAS_PER_RBT = 10000000;
    uint public constant HARD_CAP = 500000000000000;
    RiobitToken public token;
    RiobitTokenWhitelist public whitelist;
    uint public emmasRaised;
    bool private closed;

    function RioBitTokenSale(RiobitToken _token, RiobitTokenWhitelist _whitelist) public {
        require(_token != address(0));
        token = _token;
        whitelist = _whitelist;
    }

    function() external payable {
        require(!closed);
        require(msg.value != 0);
        require(whitelist.isRegistered(msg.sender));

        uint emmasToTransfer = msg.value.mul(EMMAS_PER_RBT);
        uint RBToRefund = 0;
        if (emmasRaised + emmasToTransfer > HARD_CAP) {
            emmasToTransfer = HARD_CAP - emmasRaised;
            RBToRefund = msg.value - emmasToTransfer.div(EMMAS_PER_RBT);
            closed = true;
        }
        emmasRaised = emmasRaised.add(emmasToTransfer);
        if (RBToRefund > 0) {
            msg.sender.transfer(RBToRefund);
        }

        token.transfer(msg.sender, emmasToTransfer);
    }
}