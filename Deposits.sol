pragma solidity ^0.8.0;

contract DepositContract {
    mapping (address => uint) private deposits;
    uint public totalDeposits;

    function deposit() public payable {
      deposits[msg.sender]+= msg.value;
      totalDeposits += msg.value;
    }

    function withdraw(address payable withdrawingAcc) public {
      if(msg.sender == withdrawingAcc){

        if(deposits[withdrawingAcc] > 0){
          uint temp = deposits[withdrawingAcc];
          deposits[withdrawingAcc] = 0;
          totalDeposits -= temp;
          withdrawingAcc.transfer(temp);
        }
        else{
          require(deposits[withdrawingAcc] > 0, "You have no ETH to withdraw");
        }


      }
      else{
        require(msg.sender == withdrawingAcc, "You are not the owner of this account");
      }
    
    }

    function getTotalDeposits() public view returns (uint) {
      return totalDeposits;
    }
}
