import {
  TASK_COMPILE_SOLIDITY_COMPILE,
  TASK_COMPILE_SOLIDITY_GET_ARTIFACT_FROM_COMPILATION_OUTPUT,
} from "hardhat/builtin-tasks/task-names";

import { subtask, internalTask } from "hardhat/config";
import { addGasToAbiMethods, setupNativeSolc } from "../utils/tasks";

// Injects network block limit (minus 1 million) in the abi so
// ethers uses it instead of running gas estimation.
subtask(TASK_COMPILE_SOLIDITY_GET_ARTIFACT_FROM_COMPILATION_OUTPUT)
  .setAction(async (_, { network }, runSuper) => {
    const artifact = await runSuper();

    // These changes should be skipped when publishing to npm.
    // They override ethers' gas estimation
    if (!process.env.SKIP_ABI_GAS_MODS){
      artifact.abi = addGasToAbiMethods(network.config, artifact.abi);
    }

    return artifact;
  }
);

// Use native solc if available locally at config specified version
internalTask(TASK_COMPILE_SOLIDITY_COMPILE).setAction(setupNativeSolc);

export {};
