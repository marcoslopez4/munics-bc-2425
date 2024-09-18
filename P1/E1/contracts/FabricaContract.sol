pragma solidity ^0.8.10;

contract FabricaContract {

    uint idDigits = 16;

    struct Producto {
        string nombre;
        uint id;
    }

    Producto[] public productos;

}
