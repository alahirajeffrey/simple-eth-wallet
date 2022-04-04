//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

contract Wallet {
    //mapping to hold ether balances
    mapping(address => uint256) public balances;

    //event when ether is recieved
    event recieved(address _addr, uint256 _amount);
    //event when ether is sent
    event sent(address _addr, uint256 _amount);

    //modifier to verify ether balance
    modifier hasEnough(address _addr, uint256 _amount) {
        require(balances[_addr] >= _amount, "Insufficient funds");
        _;
    }

    //recieve ether
    function recieve() external payable {
        balances[msg.sender] += msg.value;
        emit recieved(msg.sender, msg.value);
    }

    //send ether
    function sendEther(address _reciever, uint256 _amount)
        external
        payable
        hasEnough(msg.sender, _amount)
    {
        balances[_reciever] += _amount;
        balances[msg.sender] -= _amount;
        emit sent(_reciever, _amount);
    }

    //check balance
    function checkBalance(address _addr) external view returns (uint256) {
        return balances[_addr];
    }

    //check contract balance
    function checkContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
