//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract StructEnum {
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

    constructor(){
        owner = msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256){
        require(_products.length > 0, "No Products.");

        // Order memory order;
        // order.customer = msg.sender;
        // order.zipCode = _zipCode;
        // order.products = _products;
        // order.status = Status.Taken;
        // orders.push(order);

        // orders.push(
        //     Order({
        //         customer : msg.sender,
        //         zipCode : _zipCode,
        //         products : _products,
        //         status : Status.Taken
        //     })
        // );

        orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));

        return orders.length -1;
    }

    function advanceOrder(uint256 _orderId) external {
        require(owner == msg.sender, "You are not authorized.");
        require(_orderId < orders.length, "Not a valid order id");

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

    function getOrder(uint256  _orderId) external view returns(Order memory) {
        require(_orderId < orders.length, "Not a valid order id");
        return orders[_orderId];
    }

    function updateZip(uint _orderId, string memory _zipCode) external{
        require(_orderId < orders.length, "Not a valid order id");

        Order storage order =  orders[_orderId];

        require(order.customer == msg.sender, "You are not owner.");
        require(order.status  != Status.Shipped, "Order is already shipped.");

        order.zipCode = _zipCode;
    } 
    
}