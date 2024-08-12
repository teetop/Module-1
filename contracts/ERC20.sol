// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;



contract ERC20 {

    address immutable owner;
    uint256 public totalSupply;

    mapping(address  => uint256 ) public balancesOf;

    event TokenMinted(address owner, address to, uint256 value);
    event Transfer(address sender, address _to, uint256 _value);
    event Burned(address burner, uint256 _value);

    constructor() {
      owner = msg.sender;
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "ONLY_OWNER");
        _;
    }

    modifier addressZeroCheck(address _to) {
        require(_to != address(0), "Address zero not allowed!");
        _;
    }

  

    function mint(address _to, uint256 _value) public onlyOwner addressZeroCheck(_to) {
    
        balancesOf[_to] = balancesOf[_to] + _value;
        totalSupply = totalSupply + _value;

        emit TokenMinted(msg.sender, _to, _value);
    }

    
    function transfer(address _to, uint256 _value) external addressZeroCheck(_to) returns (bool) {

        uint256 balance = balancesOf[msg.sender];
        
        balancesOf[msg.sender] = balancesOf[msg.sender] - _value;

        assert(balancesOf[msg.sender] == (balance - _value));

        balancesOf[_to] = balancesOf[_to] + _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    function burn(uint96 _value) external {
        if (balancesOf[msg.sender] < _value) revert("Insufficient balance!");

        balancesOf[msg.sender] = balancesOf[msg.sender] - _value;
        totalSupply = totalSupply - _value;

        balancesOf[address(0)] = balancesOf[address(0)] + _value;

        emit Burned(msg.sender, _value);
    }
}