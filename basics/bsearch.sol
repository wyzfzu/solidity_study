// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BSearch {
    function binarySearch(int256[] memory arr, int256 val) public pure returns (int256) {
        uint low = 0;
        uint high = arr.length - 1;

        while (low <= high) {
            uint mid = low + (high - low) / 2;
            if (arr[mid] == val) {
                return int256(mid);
            } else if (arr[mid] < val) {
                low = mid + 1;
            } else {
                if (mid == 0) {
                    break;
                }
                high = mid - 1;
            }
        }

        return -1;
    }
}