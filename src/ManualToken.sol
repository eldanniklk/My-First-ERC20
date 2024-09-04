//SPDX-license-identifier: MIT


pragma solidity ^0.8.0;

contract ManualToken {

    mapping (address => uint) private s_balances;

    function name() public pure returns (string memory){
        return "Manual Token";
}

    function totalSupply () public pure returns (uint256 ){
        return 100 ether; // 1000000000000000000

}

    function decimals () public pure returns (uint8){
        return 18;



}
  
  function balanceOf(address _owner) public view returns (uint256 )
  {
    return s_balances[_owner];
  }

    function transefer(address _to, uint256 _amount ) public {
        uint256 previousBalances = balanceOf(msg.sender) + balanceOf (_to);
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        require (s_balances[msg.sender]+ s_balances[_to] == previousBalances);

    }


}