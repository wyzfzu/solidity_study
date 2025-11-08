// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Roma2Int {

    function getValue(bytes1 ch) private pure returns (uint) {
        if (ch == 'I') {
            return 1;
        }
        if (ch == 'V') {
            return 5;
        }
        if (ch == 'X') {
            return 10;
        }
        if (ch == 'L') {
            return 50;
        }
        if (ch == 'C') {
            return 100;
        }
        if (ch == 'D') {
            return 500;
        }
        if (ch == 'M') {
            return 1000;
        }

        return 0;
    }

    function convert(string memory roma) public pure returns (uint) {
        bytes memory bstr = bytes(roma);
        uint num = 0;
        uint prev = 0;
        for (uint i = bstr.length; i > 0; ) {
            --i;
            uint current = getValue(bstr[i]);
            if (current < prev) {
                num -= current;
            } else {
                num += current;
            }
            prev = current;
        }

        return num;
    }
}