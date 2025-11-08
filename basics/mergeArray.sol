// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArray {

    function mergeSortArray(int256[] memory a, int256[] memory b) public pure returns (int256[] memory) {
        uint len = a.length + b.length;
        int256[] memory c = new int256[](len);
        uint i = 0;
        uint j = 0;
        uint k = 0;

        while (j < a.length && k < b.length) {
            if (a[j] <= b[k]) {
                c[i] = a[j];
                ++j;
            } else {
                c[i] = b[k];
                ++k;
            }
            ++i;
        }
        

        for (; j < a.length; ++j) {
            c[i] = a[j];
            ++i;
        }

        for (; k < b.length; ++k) {
            c[i] = b[k];
            ++i;
        }

        return c;
    }
}