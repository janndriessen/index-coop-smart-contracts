// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

import { Address } from "@openzeppelin/contracts/utils/Address.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { BaseAdapter } from "../lib/BaseAdapter.sol";
import { IBaseManager } from "../interfaces/IBaseManager.sol";
import { IComptroller } from "../interfaces/IComptroller.sol";
import { ISetToken } from "../interfaces/ISetToken.sol";
import { PreciseUnitMath } from "../lib/PreciseUnitMath.sol";

contract CompReinvestmentAdapter is BaseAdapter {
  using Address for address;
  using PreciseUnitMath for uint256;
  using SafeMath for uint256;

  address public constant comp = address(0xc00e94Cb662C3520282E6f5717214004A7f26888);

  /* ============ State Variables ============ */

  ISetToken public setToken;

  // Compound Comptroller contract
  IComptroller internal comptroller;

  constructor(
    IBaseManager _manager,
    IComptroller _comptroller
  )
    public
    BaseAdapter(_manager)
  {
      comptroller = _comptroller;
      setToken = manager.setToken();
  }

  /* ============ External Functions ============ */

  function reinvest() external onlyOperator {
    uint256 claimableAmount = _claimableComp();
    // TODO: specify minimum amount to claim?
    require(claimableAmount > 1, "Reinvestment failed - not enough COMP to claim");
    _claimComp();
    _sellComp();
    // TODO: reinvest for cETH?
  }

  /* ============ Internal Functions ============ */

  function _claimableComp() internal view returns(uint256) {
    // TODO: get correct address?
    uint256 balance = IERC20(comp).balanceOf(address(this));
    return balance;
  }

  function _claimComp() internal {
    // TODO: get correct address
    comptroller.claimComp(address(this));
  }

  function _sellComp() internal {
    uint256 _comp = IERC20(comp).balanceOf(address(this));
    // TODO: sell in exchange for what token?
    // TODO: sell via uni/sushi?
  }
}
