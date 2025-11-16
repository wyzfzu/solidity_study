// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
任务目标
使用 Solidity 编写一个合约，允许用户向合约地址发送以太币。
记录每个捐赠者的地址和捐赠金额。
允许合约所有者提取所有捐赠的资金。

任务步骤
编写合约
创建一个名为 BeggingContract 的合约。
合约应包含以下功能：
一个 mapping 来记录每个捐赠者的捐赠金额。
一个 donate 函数，允许用户向合约发送以太币，并记录捐赠信息。
一个 withdraw 函数，允许合约所有者提取所有资金。
一个 getDonation 函数，允许查询某个地址的捐赠金额。
使用 payable 修饰符和 address.transfer 实现支付和提款。
部署合约
在 Remix IDE 中编译合约。
部署合约到 Goerli 或 Sepolia 测试网。
测试合约
使用 MetaMask 向合约发送以太币，测试 donate 功能。
调用 withdraw 函数，测试合约所有者是否可以提取资金。
调用 getDonation 函数，查询某个地址的捐赠金额。

任务要求
合约代码：
使用 mapping 记录捐赠者的地址和金额。
使用 payable 修饰符实现 donate 和 withdraw 函数。
使用 onlyOwner 修饰符限制 withdraw 函数只能由合约所有者调用。
测试网部署：
合约必须部署到 Goerli 或 Sepolia 测试网。
功能测试：
确保 donate、withdraw 和 getDonation 函数正常工作。

提交内容
合约代码：提交 Solidity 合约文件（如 BeggingContract.sol）。
合约地址：提交部署到测试网的合约地址。
测试截图：提交在 Remix 或 Etherscan 上测试合约的截图。

额外挑战（可选）
捐赠事件：添加 Donation 事件，记录每次捐赠的地址和金额。
捐赠排行榜：实现一个功能，显示捐赠金额最多的前 3 个地址。
时间限制：添加一个时间限制，只有在特定时间段内才能捐赠。
*/

import "@openzeppelin/contracts/access/Ownable.sol";

contract BeggingContract is Ownable {

    mapping(address => uint256) private donates;
    uint256 private constant SECONDS_PER_HOUR = 3600;
    uint256 private constant SECONDS_PER_DAY = 24 * SECONDS_PER_HOUR;
    
    // 早上10点 = 10 * 3600 = 36000秒
    uint256 private constant MORNING_START = 10 * SECONDS_PER_HOUR; // 10:00 UTC
    // 晚上10点 = 22 * 3600 = 79200秒
    uint256 private constant EVENING_END = 22 * SECONDS_PER_HOUR;   // 22:00 UTC

    constructor() Ownable(msg.sender) {
        
    }

    event Donation(address indexed donor, uint256 amount);

    function _isInTimeRange(uint256 timestamp) internal pure returns (bool) {
        // 获取当天已过去的秒数
        uint256 secondsToday = timestamp % SECONDS_PER_DAY;
        
        // 检查是否在 10:00 - 22:00 之间
        return secondsToday >= MORNING_START && secondsToday < EVENING_END;
    }

    function donate() public payable {
        require(_isInTimeRange(block.timestamp), "donate time is not allowed, only between 10:00 and 22:00");
        uint256 amount = msg.value;
        require(amount > 0, "donate amount must great then zero.");
        donates[msg.sender] += amount;

        emit Donation(msg.sender, amount);
    }

    function withdraw() public payable onlyOwner {
        uint256 total = address(this).balance;
        require(total > 0, "no money to withdraw.");

        (bool success, ) = payable(owner()).call{value: total}("");
        require(success, "withdraw fail");
    }

    function getDonation(address donor) public view returns(uint256) {
        require(donor != address(0), "donor is a zero address.");
        return donates[donor];
    }
}