// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Int2Roma {
    function intToRoman(uint num) public pure returns(string memory) {
        bytes memory sb;
        while (num != 0) {
            if (num >= 1000) {
                sb = bytes.concat(sb, 'M');
                num -= 1000;
            } else if (num >= 900) {
                sb = bytes.concat(sb, bytes("CM"));
                num -= 900;
            } else if (num >= 500) {
                sb = bytes.concat(sb, 'D');
                num -= 500;
            } else if (num >= 400) {
                sb = bytes.concat(sb, bytes("CD"));
                num -= 400;
            } else if (num >= 100) {
                sb = bytes.concat(sb, 'C');
                num -= 100;
            } else if (num >= 90) {
                sb = bytes.concat(sb, bytes("XC"));
                num -= 90;
            } else if (num >= 50) {
                sb = bytes.concat(sb, 'L');
                num -= 50;
            } else if (num >= 40) {
                sb = bytes.concat(sb, bytes("XL"));
                num -= 40;
            } else if (num >= 10) {
                sb = bytes.concat(sb, 'X');
                num -= 10;
            } else if (num >= 9) {
                sb = bytes.concat(sb, bytes("IX"));
                num -= 9;
            } else if (num >= 5) {
                sb = bytes.concat(sb, 'V');
                num -= 5;
            } else if (num >= 4) {
                sb = bytes.concat(sb, bytes("IV"));
                num -= 4;
            } else {
                sb = bytes.concat(sb, 'I');
                --num;
            }
        }
        return string(sb);
    }
}