import * as dotenv from "dotenv";
import { Transaction } from "@mysten/sui/transactions";
import { bcs } from "@mysten/sui/bcs";
import getExecStuff from "./utils/execStuff";

dotenv.config();

const packageId = process.env.PACKAGE_ID;
const moduleName = "dynamic_nft";
const functionName = "update_mode";
const nftID = "";

const create_nft = async (nftid) => {
  const tx = new Transaction();
  const { keypair, client } = getExecStuff();

  tx.moveCall({
    target: `${packageId}::${moduleName}::${functionName}`,
    arguments: [tx.object(nftid)],
  });

  try {
    const result = await client.signAndExecuteTransaction({
      signer: keypair,
      transaction: tx,
    });

    const transaction = await client.waitForTransaction({
      digest: result.digest,
      options: {
        showEffects: true,
      },
    });

    console.log(`Transaction Digest: ${transaction.digest}`);
  } catch (e) {
    console.error(`Failed to mint NFT `, e);
  }
};

create_nft(nftID);
