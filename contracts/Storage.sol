pragma solidity ^0.4.2;
// SPDX-License-Identifier: UNLICENSED

contract Storage{

  mapping(string => uint256) _uintStorage;
  mapping(string => string) _stringStorage;
  mapping(string => bool) _boolStorage;
  mapping(string => bytes) _byteStorage;
  mapping(string => address) _addressStorage;

  address public ownerAddress;
  bool initialized = false;



}
