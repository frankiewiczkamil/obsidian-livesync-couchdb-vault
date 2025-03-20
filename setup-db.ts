import { encrypt } from "npm:octagonal-wheels@0.1.11/encryption/encryption.js";


const passphrase = Deno.env.get("passphrase");
const hostname = Deno.env.get("hostname");
const username = Deno.env.get("username");
const password = Deno.env.get("password");
const database = Deno.env.get("database");

console.log(`${username}@${hostname}/${database}`);

const URIBASE = "obsidian://setuplivesync?settings=";
async function main() {
    const conf = {
        couchDB_URI: hostname,
        couchDB_USER: username,
        couchDB_PASSWORD: password,
        couchDB_DBNAME: database,
        syncOnStart: true,
        gcDelay: 0,
        periodicReplication: true,
        syncOnFileOpen: true,
        encrypt: true,
        passphrase,
        usePathObfuscation: true,
        batchSave: true,
        batch_size: 50,
        batches_limit: 50,
        useHistory: true,
        disableRequestURI: true,
        customChunkSize: 50,
        syncAfterMerge: false,
        concurrencyOfReadChunksOnline: 100,
        minimumIntervalOfReadChunksOnline: 100,
        handleFilenameCaseSensitive: false,
        doNotUseFixedRevisionForChunks: false,
        settingVersion: 10,
        notifyThresholdOfRemoteStorageSize: 800,
    };
    const encryptedConf = encodeURIComponent(await encrypt(JSON.stringify(conf), passphrase, false));
    const theURI = `${URIBASE}${encryptedConf}`;
    console.log(theURI);
}
await main();