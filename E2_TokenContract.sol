// SPDX-License-Identifier: Unlicenced
pragma solidity ^0.8.18;

contract TokenContract {
    uint immutable tokenCost = 5;

    address public owner;

    struct Receivers {
        string name;
        uint256 tokens;
    }

    mapping(address => Receivers) public users;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
        users[owner].tokens = 100;
    }

    function double(uint _value) public pure returns (uint) {
        return _value*2;
    }

    function register(string memory _name) public {
        users[msg.sender].name = _name;
    }

    function giveToken(address _receiver, uint256 _amount) onlyOwner public {
        require(users[owner].tokens >= _amount);
        users[owner].tokens -= _amount;
        users[_receiver].tokens += _amount;
    }

    //onlyOwner?
    //Concurrencia
    //Mensajes de error
    //mala implementación de actualización de balances
    function _buyToken(address _buyer, address _seller, uint256 _amount) public {
        uint newBuyerBalance = 0;
        uint newSellerBalance = 0;
        if (_buyer.balance >= _amount * tokenCost && users[_seller].tokens >= _amount) {
            newBuyerBalance = _buyer.balance - _amount * tokenCost;
            _buyer.balance = newBuyerBalance;
            users[_buyer].tokens += _amount;

            newSellerBalance = _seller.balance + _amount * tokenCost;
            _seller.balance = newSellerBalance;
            users[_seller].tokens -= _amount;
        } //else if ()

    }
}