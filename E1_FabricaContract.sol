pragma solidity ^0.8.10;

contract FabricaContract {
    uint idDigits = 16;

    struct Producto {
        uint id; // identificación del producto
        string nombre;  // nombre del producto
    }

    Producto[] public productos;


    function _crearProducto(uint _id, string memory _nombre) private {
        productos.push(Producto(_id,_nombre));
        emit NuevoProducto(productos.length-1,_id,_nombre);
    }

    function _generarIdAleatorio(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        uint idModulus = 10**idDigits;
        return rand % idModulus;
    }

    function _crearProductoAleatorio(string memory _nombre) public {
        uint randId = _generarIdAleatorio(_nombre);
        _crearProducto(randId,_nombre);
    }


    event NuevoProducto(uint ArrayProductoId, uint id, string nombre);


    mapping (uint => address) public productoAPropietario;
    mapping (address => uint) propietarioProductos;


    function Propiedad(uint _productoId) private {
        productoAPropietario[_productoId] = msg.sender;
        propietarioProductos[msg.sender]++;
    }

    function getProductosPorPropietario(address _propietario) external view {
        uint contador = 0;
        uint[] memory resultado;
        for (contador = 0; contador < productos.length; contador++) {
            producto = productos[contador];
            if (productoAPropietario(producto.id) == _propietario) {
                resultado.push(producto);
            }
        }
    }


}
