import * as dotenv from "dotenv";
import { Transaction } from "@mysten/sui/transactions";
import { bcs } from "@mysten/sui/bcs";
import getExecStuff from "./utils/execStuff";

dotenv.config();

const packageId = process.env.PACKAGE_ID;
const moduleName = "dynamic_nft";
const functionName = "create_dynamic_nft";

const create_nft = async (
  addresses,
  nftname,
  description,
  day_image_url,
  night_image_url
) => {
  const tx = new Transaction();
  const { keypair, client } = getExecStuff();

  const add = bcs.Address.serialize(addresses);

  tx.moveCall({
    target: `${packageId}::${moduleName}::${functionName}`,
    arguments: [
      tx.pure(add),
      tx.pure.string(nftname),
      tx.pure.string(description),
      tx.pure.string(day_image_url),
      tx.pure.string(night_image_url),
    ],
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

create_nft();
