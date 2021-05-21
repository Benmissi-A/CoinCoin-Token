// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CoinCoin {

  mapping(address => uint256) private _balances;
  mapping(address => mapping(address => uint256)) private _allowances;
  string private _name;
  string private _symbol;
  uint256 private _totalSupply;

  event Transfer(address indexed sender, address indexed receipient, uint256 amount);
  event Transfered(address indexed sender,address indexed recipient, uint256 amount);
  event TransferedFrom(address indexed from,address indexed to, uint256 amount);
  event Approval(address indexed sender, address indexed spender, uint256 amount);

  constructor(address owner_, uint256 totalSupply_) {
    _name = "CoinCoin";
    _symbol = "COIN";
    _balances[owner_] = totalSupply_;
    emit Transfer(address(0), owner_, totalSupply_);
  }
  
  function name() public view returns (string memory) {
    return _name;
  }

  function symbol() public view returns (string memory) {
    return _symbol;
  }

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address account_) public view returns (uint256) {
    return _balances[account_];
  }

  function allowance(address owner_, address spender_) public view returns (uint256) {
    return _allowances[owner_][spender_];
  }

  function approve(address sender , address spender, uint256 amount) public  {
    require(sender != address(0), "CoinCoin: approve from the zero address");
    require(spender != address(0), "CoinCoin: approve to the zero address");

    _allowances[sender][spender] = amount;
    emit Approval(sender, spender, amount);
  }

  function transfer(address sender_ ,address recipient_, uint256 amount_) public {
    require( amount_ > 0, "CoinCoin: can not transfer 0 ether"  );
    require( _balances[sender_] >= amount_,"CoinCoin: Not enough Ether to transfer");
    require( recipient_ != address(0),"CoinCoin: transfer to the zero address" );
    _balances[sender_] -= amount_;
    _balances[recipient_] += amount_;
    emit Transfered(sender_, recipient_, amount_);
  }

  function transferFrom( address from_, address to_,uint256 amount_ ) public {
    require(_allowances[from_][to_] >= amount_, "CoinCoin: You don't have any funds allowed anymore.");
    _allowances[from_][to_] -= amount_;
    _balances[from_] -= amount_;
    _balances[to_] += amount_;
    emit TransferedFrom(from_, to_, amount_);
  }

}