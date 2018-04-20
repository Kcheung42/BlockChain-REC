pragma solidity ^0.4.18;

import "./ERC721.sol";

contract REC is ERC721 {

	/*** CONSTANTS ***/

	string public constant name = "RenerableEnergyCertificate";
	string public constant symbol = "REC";

	bytes4 constant InterfaceID_ERC165 =
		bytes4(keccak256('supportsInterface(bytes4)'));

	bytes4 constant InterfaceID_ERC721 =
		bytes4(keccak256('name()')) ^
	bytes4(keccak256('symbol()')) ^
	bytes4(keccak256('totalSupply()')) ^
	bytes4(keccak256('balanceOf(address)')) ^
	bytes4(keccak256('ownerOf(uint256)')) ^
	bytes4(keccak256('approve(address,uint256)')) ^
	bytes4(keccak256('transfer(address,uint256)')) ^
	bytes4(keccak256('transferFrom(address,address,uint256)')) ^
	bytes4(keccak256('tokensOfOwner(address)'));


	/*** DATA TYPES ***/

	struct Token {
		address mintedBy;
		uint64 mintedAt;
	}


	/*** STORAGE ***/

	Token[] tokens;

	mapping (uint256 => address) public tokenIndexToOwner;
	mapping (address => uint256) ownershipTokenCount;
	mapping (uint256 => address) public tokenIndexToApproved;


	/*** EVENTS ***/

	event Mint(address owner, uint256 tokenId);


	event testValue(uint256 indexed value1);
	/*** INTERNAL FUNCTIONS ***/

	function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
		return tokenIndexToOwner[_tokenId] == _claimant;
	}

	function _approvedFor(address _claimant, uint256 _tokenId) internal view returns (bool) {
		return tokenIndexToApproved[_tokenId] == _claimant;
	}

	function _approve(address _to, uint256 _tokenId) internal {
		tokenIndexToApproved[_tokenId] = _to;

		Approval(tokenIndexToOwner[_tokenId], tokenIndexToApproved[_tokenId], _tokenId);
	}

	function _transfer(address _from, address _to, uint256 _tokenId) internal {
		ownershipTokenCount[_to]++;
		testValue(ownershipTokenCount[_to]);
		tokenIndexToOwner[_tokenId] = _to;

		if (_from != address(0)) {
			ownershipTokenCount[_from]--;
			delete tokenIndexToApproved[_tokenId];
		}

		Transfer(_from, _to, _tokenId);
	}

	function _mint(address _owner) internal returns (uint256 tokenId) {
		Token memory token = Token({
			mintedBy: _owner,
			mintedAt: uint64(now)
		});
		tokenId = tokens.push(token) - 1;

		Mint(_owner, tokenId);

		_transfer(0, _owner, tokenId);
		return tokenId;
	}


	/*** ERC721 IMPLEMENTATION ***/

	function supportsInterface(bytes4 _interfaceID) external view returns (bool) {
		return ((_interfaceID == InterfaceID_ERC165) || (_interfaceID == InterfaceID_ERC721));
	}

	function totalSupply() public view returns (uint256) {
		return tokens.length;
	}

	function balanceOf(address _owner) public view returns (uint256) {
		return ownershipTokenCount[_owner];
	}

	function ownerOf(uint256 _tokenId) external view returns (address owner) {
		owner = tokenIndexToOwner[_tokenId];

		require(owner != address(0));
		return owner;
	}

	function approve(address _to, uint256 _tokenId) external {
		require(_owns(msg.sender, _tokenId));

		_approve(_to, _tokenId);
}

	function transfer(address _to, uint256 _tokenId) external {
		require(_to != address(0));
		require(_to != address(this));
		require(_owns(msg.sender, _tokenId));

		_transfer(msg.sender, _to, _tokenId);
	}

	function transferFrom(address _from, address _to, uint256 _tokenId) external {
		require(_to != address(0));
		require(_to != address(this));
		require(_approvedFor(msg.sender, _tokenId));
		require(_owns(_from, _tokenId));

		_transfer(_from, _to, _tokenId);
	}

	function tokensOfOwner(address _owner) external view returns (uint256[]) {
		uint256 balance = balanceOf(_owner);

		if (balance == 0) {
			return new uint256[](0);
		} else {
			uint256[] memory result = new uint256[](balance);
			uint256 maxTokenId = totalSupply();
			uint256 idx = 0;

			uint256 tokenId;
			for (tokenId = 1; tokenId <= maxTokenId; tokenId++) {
				if (tokenIndexToOwner[tokenId] == _owner) {
					result[idx] = tokenId;
					idx++;
				}
			}
		}

		return result;
	}


	/*** OTHER EXTERNAL FUNCTIONS ***/

	function mint() external returns (uint256) {
		return _mint(msg.sender);
	}

	function getToken(uint256 _tokenId) external view returns (address mintedBy, uint64 mintedAt) {
		Token memory token = tokens[_tokenId];

		mintedBy = token.mintedBy;
		mintedAt = token.mintedAt;
	}
}
