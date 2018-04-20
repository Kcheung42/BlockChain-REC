pragma solidity ^0.4.17;

import "./ConvertLib.sol";
import "./REC.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin is REC{

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function MetaCoin() public {
		for(int i=0;i < 10;i++){
			mint("EDF", "solar");
		}
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		uint256 balance = balanceOf(msg.sender);
		uint256[] memory tokenlist = tokensOfOwner(msg.sender);

		if (amount <= balance){
			for(uint i=0; i < amount; i++){
				_transfer(msg.sender, receiver, tokenlist[i]);
			}
			return true;
		}
		return false;
	}

	function getBalance(address addr) public view returns(uint) {
		return balanceOf(addr);
	}

}
