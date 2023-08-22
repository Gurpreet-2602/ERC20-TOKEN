//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

interface ERC20Interface {
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external returns (bool success);
    
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
 contract Block is ERC20Interface{

    string public name= "Block";
    string public symbol = "BLK";
    uint public decimal = 0;
    uint public override totalSupply;//state variable - getter function 
    address public founder;
    mapping(address=>uint) public balances;//store balances of an address.
    mapping(address=>mapping(address=>uint)) allowed;

    constructor(){
        totalSupply=1000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }
        function balanceOf(address _owner) external view override returns (uint256 balance){
            return balances[_owner];
        } 
        function transfer(address _to, uint256 _value) external  override returns (bool success){
            require(balances[msg.sender]>_value,"You have insufficient balances");
            balances[_to]+=_value;
            balances[msg.sender]-=_value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
         function allowance(address _owner, address _spender) external override view returns (uint256 remaining){
            return allowed[_owner][_spender];
         }
          function approve(address _spender, uint256 _value) external override returns (bool success){
            require(balances[msg.sender]>=_value,"you have insufficient balance");
            require(_value>0,"Zero number of tokens cannot be approved");
            allowed[msg.sender][_spender]=_value;
            emit Approval(msg.sender, _spender, _value);
            return true;
          }
              function transferFrom(address _from, address _to, uint256 _value) external override returns (bool success){
                require(allowed[_from][_to]>=_value,"You are not approved for this much of tokens");
                require(balances[_from]>=_value,"you have insufficient balance");
                balances[_from]-=_value;
                balances[_to]+=_value;
              emit Transfer(msg.sender, _to, _value);
              return true;
              }

}