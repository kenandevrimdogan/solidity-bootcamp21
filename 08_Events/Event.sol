//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Events {
    enum Status {
        Taken,
        Preparing,
        Boxed,
        Shipped
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    address public owner;
    uint256 public txCount;

    event OrderCreated(uint256 _orderId, address indexed _consumer);
    event ZipChanged(uint256 _orderId, string _zipcode);

    constructor(){
        owner = msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products)  checkProducts(_products) incTx external returns(uint256){
        orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));

        emit OrderCreated(orders.length -1, msg.sender);
        return orders.length -1;
    }

    function advanceOrder(uint256 _orderId)  checkOrderId(_orderId) onlyOwner external {
        Order storage order =  orders[_orderId];
        require(order.status  != Status.Shipped, "Order is already shipped.");

        if(order.status == Status.Taken){
            order.status = Status.Preparing;
        }
        else if(order.status == Status.Preparing){
            order.status = Status.Boxed;
        }
        else if(order.status == Status.Boxed){
            order.status = Status.Shipped;
        }
    }

    function getOrder(uint256  _orderId) checkOrderId(_orderId) onlyCustomer(_orderId) external view returns(Order memory) {
        return orders[_orderId];
    }

    function updateZip(uint _orderId, string memory _zipCode) incTx onlyCustomer(_orderId) checkOrderId(_orderId) external{
        Order storage order =  orders[_orderId];

        require(order.status  != Status.Shipped, "Order is already shipped.");

        order.zipCode = _zipCode;

        emit ZipChanged(_orderId, _zipCode);
    } 
    
    modifier checkProducts(uint256[] memory _products) {
        require(_products.length > 0, "No Products.");
        _; // body
    }

    modifier checkOrderId(uint256 _orderId){
        require(_orderId < orders.length, "Not a valid order id");
        _; // body
    }

    modifier incTx {
        _; // body

        txCount++;
    }

    modifier onlyOwner {
        require(owner == msg.sender, "You are not authorized.");

        _; // body
    }

    modifier onlyCustomer(uint256  _orderId) {
        require(orders[_orderId].customer == msg.sender, "You are not owner.");
        _; // body
    }
}