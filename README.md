
# ERC20

This Solidity program is a simple smart contract that mimics the ECR20 token. The contracts allow the contract to mint tokens to other addresses. The different accounts can transfer these tokens and burn them. The purpose of this program is to show the Solidity way of handling errors in smart contracts.

## Description

This program is a simple contract written in Solidity, a programming language for developing smart contracts on the Ethereum blockchain. The contract shows the three error-handling mechanisms ```require, revert, assert```. The contract has five functions as listed below.

- ```mint```: allows the owner to mint tokens to an address. The modifier that makes sure only the owner can call this function uses ```require``` to makes sure only the owner can call the function. ```require``` is also used to make sure the address to mint to is not address zero. ```assert``` makes sure that the token in circulation does not exceed the MAXIMUM SUPPLY.
- ```transfer```: allows an account to transfer tokens to another account. ```require``` is used to make sure the receiver is not an address zero. ```assert``` is used to ascertain the balance after transfer.
- ```burn```: this allows an account to burn its token. ```revert``` is used to make sure the account balance is not less than the intended burn amount.
- ```balanceOf```: allows a user to check his token balance
- ```totalSupply```: shows the total token in circulation

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., ERC20.sol). Copy and paste the following code into the file:

```javascript
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
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile ERC20.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "ERC20" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it the contract.

## Authors

Temitope Taiwo

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
