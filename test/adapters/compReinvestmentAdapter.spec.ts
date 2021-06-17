import "module-alias/register";

import { Address, Account } from "@utils/types";
import { CompReinvestmentAdapter, BaseManager } from "@utils/contracts/index";
import { SetToken } from "@utils/contracts/setV2";
import DeployHelper from "@utils/deploys";
import {
  addSnapshotBeforeRestoreAfterEach,
  ether,
  getAccounts,
  getLastBlockTimestamp,
  getSetFixture,
  getStreamingFee,
  getStreamingFeeInflationAmount,
  getTransactionTimestamp,
  getWaffleExpect,
  increaseTimeAsync,
  preciseMul,
} from "@utils/index";
import { SetFixture } from "@utils/fixtures";

const expect = getWaffleExpect();

describe("CompReinvestmentAdapter", () => {
  let owner: Account;
  let methodologist: Account;
  let operator: Account;
  let setV2Setup: SetFixture;

  let deployer: DeployHelper;
  let setToken: SetToken;

  let baseManagerV2: BaseManager;

  before(async () => {
    [owner, methodologist, operator] = await getAccounts();

    deployer = new DeployHelper(owner.wallet);

    setV2Setup = getSetFixture(owner.address);
    await setV2Setup.initialize();

    setToken = await setV2Setup.createSetToken(
      [setV2Setup.dai.address],
      [ether(1)],
      [setV2Setup.debtIssuanceModule.address, setV2Setup.streamingFeeModule.address],
    );

    // Deploy BaseManager
    baseManagerV2 = await deployer.manager.deployBaseManager(
      setToken.address,
      operator.address,
      methodologist.address,
    );
  });

  describe("#constructor", async () => {
    let subjectManagerAddress: Address;

    beforeEach(async () => {
      subjectManagerAddress = baseManagerV2.address;
    });

    async function subject(): Promise<CompReinvestmentAdapter> {
      return await deployer.adapters.deployCompReinvestmentAdapter(subjectManagerAddress);
    }

    it("should set the manager address", async () => {
      const retrievedAdapter = await subject();
      const manager = await retrievedAdapter.manager();
      console.log(manager);
      console.log(subjectManagerAddress);

      expect(manager).to.eq(subjectManagerAddress);
    });
  });
});
