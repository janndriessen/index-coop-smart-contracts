// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

import { Address } from "@openzeppelin/contracts/utils/Address.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { BaseAdapter } from "../lib/BaseAdapter.sol";
import { IBaseManager } from "../interfaces/IBaseManager.sol";
import { IComptroller } from "../interfaces/IComptroller.sol";
import { ISetToken } from "../interfaces/ISetToken.sol";
import { PreciseUnitMath } from "../lib/PreciseUnitMath.sol";

contract CompReinvestmentAdapter is BaseAdapter {
  // using Address for address;
  // using PreciseUnitMath for uint256;
  // using SafeMath for uint256;

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
    // TODO: check comp balance, return if < 1
    // TODO: claim comp
    // TODO: reinvest for cETH?
  }

  /* ============ Internal Functions ============ */

  function _claimableComp() internal view returns(uint256) {}

  function _claimComp() internal {
    // TODO: get correct address
    comptroller.claimComp(address(this));
  }

  function _sellComp() internal {}
}
