pragma solidity 0.6.10;

import { Address } from "@openzeppelin/contracts/utils/Address.sol";
import { SafeMath } from "@openzeppelin/contracts/math/SafeMath.sol";

import { BaseAdapter } from "../lib/BaseAdapter.sol";
import { IBaseManager } from "../interfaces/IBaseManager.sol";
import { ISetToken } from "../interfaces/ISetToken.sol";
import { PreciseUnitMath } from "../lib/PreciseUnitMath.sol";

contract CompReinvestmentAdapter is BaseAdapter {
  // using Address for address;
  // using PreciseUnitMath for uint256;
  // using SafeMath for uint256;

  // ISetToken public setToken;

  constructor(IBaseManager _manager) public BaseAdapter(_manager) {
    // setToken = manager.setToken();
  }
}
