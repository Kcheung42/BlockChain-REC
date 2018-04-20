pragma solidity ^0.4.17;

import "./ConvertLib.sol";
import "./REC.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin is REC{
	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function MetaCoin() public {
		balances[tx.origin] = 10000;
		for(int i=0;i < 42;i++){
			_mint(msg.sender);
		}
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		uint256 balance = balanceOf(msg.sender);
		uint256[] memory result = new uint256[](balance);
		// result = this.tokensOfOwner(msg.sender);

		uint tokenid = result[0];

		if (amount <= balance){
			for(uint i=0; i < amount; i++){
				_transfer(msg.sender, receiver, 1);
			}
			return true;
		}
		return false;
		// if (balances[msg.sender] < amount) return false;
		// balances[msg.sender] -= amount;
		// balances[receiver] += amount;
		// Transfer(msg.sender, receiver, amount);
		// return true;
	}

	function getBalance(address addr) public view returns(uint) {
		return balanceOf(addr);
	}

}
