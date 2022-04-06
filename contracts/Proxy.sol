pragma solidity ^0.4.2;
// SPDX-License-Identifier: UNLICENSED
import "./Storage.sol";

contract Proxy is Storage{

  // everything from here down to the
  //fallback function is the same from
  //DogsUpdated.
  address currentAddress;

  constructor(address _currentAddress){
    currentAddress = _currentAddress;
  }

  function upgrade(address _newAddress)public {

    currentAddress = _newAddress;

}
  //FALLBACK FUNCTION
  function()payable external{
    address implementation = currentAddress;
    require(currentAddress != address(0));
    bytes memory data = msg.data;

  //DELEGATECALL EVERY FUNCTION CALL TO
  // WHATEVER FUNCTIONAL SC IN OUR currentAddress
  //using the functions of dogsUpdated but with the
  //scope of the proxy state var. 
    assembly{
      let result:= delegatecall(gas, implementation, add(data,0x20), mload(data), 0,0)
      let size:= returndatasize
      let ptr:= mload(0x40)
      returndatacopy(ptr, 0, size)
      switch result
      case 0{revert (ptr,size)}
      default
      {return(ptr,size)}

    }


  }
}
