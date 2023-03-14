//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract KnowledgeTest {
    string[] public tokens = ["BTC", "ETH"];
    address[] public players;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function concatenate(string calldata a, string calldata b) external pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function changeTokens() external {
        string[] storage t = tokens;
        t[0] = "VET";
    }

    function start() external {
        players.push(msg.sender);
    }

    function transferAll(address payable recipient) external {
        require(msg.sender == owner, "ONLY_OWNER");
        (bool result, ) = recipient.call{value: getBalance()}("");
        require(result, "TX_FAILED");
    }
}
