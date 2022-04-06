pragma solidity ^0.4.2;
// SPDX-License-Identifier: UNLICENSED
//pragma abicoder v2;

import "./Storage.sol";
contract DogsUpdated is Storage{

//adding another state variable here, that isn't already defined
// in our storage contract, will corrupt the operation.
//it'll attempt to write to the new var, in the proxy scope.
// but it won't exist in proxy, so it'll overwrite something else

//there is no one delegating calls to proxy, so it may be able to
// have additional state var. 
modifier onlyOwner{
  require(msg.sender == ownerAddress);
  _;
}

constructor()public{
  initialize(msg.sender);
}

/*
 in the future, if I wanted to upgrade my DogsUpdated state variables,
 I'd do so in the initialize function. and then delegateCall into that
 initialized function, in order to set up that initial state in the proxy
 scope.
*/

function initialize(address _newOwner)public {
  require(initialized == false);
  ownerAddress = _newOwner;
  initialized = true;

}

function getNumberOfDogs()public view returns(uint){
  return _uintStorage["Dogs"];
}

function setNumberOfDogs(uint256 toSet)public onlyOwner{
  _uintStorage["Dogs"] = toSet;
}





}
