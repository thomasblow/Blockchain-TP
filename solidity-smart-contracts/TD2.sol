pragma solidity ^0.4.8;

contract Token {    //Standard norm for Token Creation Smart Contracts
    
    /// total amount of tokens
    uint256 public totalSupply;

    /// @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address _owner) constant returns (uint256 balance);

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

    /// @notice `msg.sender` approves `_spender` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of tokens to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) constant returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}






contract Fidelicoin is Token {
    
    //Variables 
    
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    
    //Creation of arrays containing with all the balances
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) allowed;
   
    //Event that will notify on the chain whenever a transfer is made
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    //Constructor
    function Fidelicoin(uint256 _initialSupply, string _TokenName, uint8 _decimalUnits, string _tokenSymbol) {
        balances[msg.sender] = _initialSupply;               // Give the creator all initial tokens
        totalSupply = _initialSupply;                        // Update total supply
        name = _TokenName;                                   // Set the name for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
    }

    
    /// @param _owner The address from which the balance will be retrieved
    /// @return The balance
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    /// @notice send `_value` token to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) returns (bool success) {
       
    if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
        
    }

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
    } else { return false; }
    }
    
    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return allowed[_owner][_spender];
    }
    
    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        return true;
    }
    
    
    function () { //Gets called whenever people want to send ether to the adress, prevents accidental transfers
        throw;     
    }

    
    
    
    
    
}


