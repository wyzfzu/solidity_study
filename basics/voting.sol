// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
一个mapping来存储候选人的得票数
一个vote函数，允许用户投票给某个候选人
一个getVotes函数，返回某个候选人的得票数
一个resetVotes函数，重置所有候选人的得票数
*/
contract Voting {
    mapping(uint256 => uint32) voteMap;
    mapping(uint256 => bool) exists;
    uint256[] candidates;

    function vote(uint256 candidate) public {
        voteMap[candidate] += 1;
        if (!exists[candidate]) {
            exists[candidate] = true;
            candidates.push(candidate);
        }
    }

    function getVotes(uint256 candidate) public view returns (uint32) {
        return voteMap[candidate];
    }

    function resetVotes() public {
        for (uint i = 0; i < candidates.length; ++i) {
            delete voteMap[candidates[i]];
            delete exists[candidates[i]];
        }
    } 

}