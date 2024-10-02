// SPDX-License-Identifier: Unlicenced
pragma solidity ^0.8.18;

contract TokenContract {
    uint immutable tokenPrice = 5000000000000000000;

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
    //Concurrencia?

    function _buyToken(address payable _seller, uint256 _amount) public payable {
        //uint newBuyerBalance = 0;
        //uint newSellerBalance = 0;

        //"cantidad de Ether del contrato inteligente"

        uint totalPrice = _amount * tokenPrice;

        //require(msg.sender.balance >= totalPrice,"Not enough Ether.");
        //Con >= el comprador puede pagar en exceso pero el vendedor no recibe el extra.
        require(msg.value == totalPrice,"Wrong Ether value. Each token costs 5 Ether.");
        require(users[_seller].tokens >= _amount,"Seller doesn't own enough tokens.");

        _seller.transfer(totalPrice);
        users[_seller].tokens -= _amount;
        users[msg.sender].tokens += _amount;

        //_buyer.balance...
        //users[_seller].tokens...



        /*if (_buyer.balance >= _amount * tokenCost && users[_seller].tokens >= _amount) {


            newBuyerBalance = _buyer.balance - _amount * tokenCost;
            _buyer.balance = newBuyerBalance;
            users[_buyer].tokens += _amount;

            newSellerBalance = _seller.balance + _amount * tokenCost;
            _seller.balance = newSellerBalance;
            users[_seller].tokens -= _amount;
        } //else if ()*/

    }
}