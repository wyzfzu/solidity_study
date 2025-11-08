// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString {

    function reverse(string memory str) public pure returns (string memory) {
        bytes memory bstr = bytes(str);
        uint len = bstr.length;
        bytes memory rstr = new bytes(len);
        
        for (uint i = 0; i < len; i++) {
            rstr[i] = bstr[len - i - 1];
        }
        return string(rstr);
    }
}