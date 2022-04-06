pragma solidity ^0.4.2;
// SPDX-License-Identifier: UNLICENSED
//pragma abicoder v2;

import "./Storage.sol";
contract Dogs is Storage{



modifier onlyOwner{
  require(msg.sender == ownerAddress);
  _;
}

constructor()public{
  ownerAddress=msg.sender;
}

function getNumberOfDogs()public view returns(uint){
  return _uintStorage["Dogs"];
}

function setNumberOfDogs(uint256 toSet)public{
  _uintStorage["Dogs"] = toSet;
}





}
