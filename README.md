This readme is for setting up full nodes/sentry nodes for BTTC network using docker-compose


0.Prerequisites

make sure install docker&docker-compose first, and we will recommended docker-compose version below:
```
docker-compose version 1.29.1, build c34c88b2
docker-py version: 5.0.0
CPython version: 3.9.0
OpenSSL version: OpenSSL 1.1.1h  22 Sep 2020
```


1.Build BTTC&Delivery images locally

```
sh images-build.sh $BTTC_VERSION $DELIVERY_VERSION

```
Example:
```
sh images-build.sh v1.0.0 v1.0.1

```
Note - make sure use the correct version.


2.Run the following commands for local volumes to be mounted in docker-compose file
```
mkdir -p delivery/scripts

mv delivery-startup.sh delivery/scripts
```

(Optional)if you want to use snapshots file to accelerate sync,download the latest snapshots from [ BTTC Chains Snapshots](https://snapshots.bt.io/).

Example:
```
wget -c https://bttc-blockchain-snapshots.s3-accelerate.amazonaws.com/bttc-mainnet/2022_03_15/bttc-mainnet-snapshot-2022_03_15.tar.gz
wget -c https://bttc-blockchain-snapshots.s3-accelerate.amazonaws.com/bttc-mainnet/2022_03_15/delivery-mainnet-snapshot-2022_03_15.tar.gz
```

Note - If you are using different snapshot files, make changes for file names accordingly in the env files. We periodically take new snapshots and will publish new links to the [ BTTC Chains Snapshots](https://snapshots.bt.io/) .

then execute follow commands.
```
mkdir -p bttc/snapshot
mkdir -p delivery/snapshot
mv <path-to-delivery-snapshot-file> delivery/snapshot
mv <path-to-bttc-snapshot-file> bttc/snapshot
```
Note - please make sure to download the snapshot files to the right place.

3.Modify the env file.
Open for editing `vim mainnet-199.env`
In `mainnet-199.env`, change the following:
* `DELIVERY_TAG` — lastest delivery release tag,make sure this tag should be same as your delivery docker images version mentioned above. Example: `DELIVERY_TAG=v1.0.0`.
* `DELIVERY_SEEDS` — seeds to sync from delivery fullnodes. Example: `DELIVERY_SEEDS="161c2cbe07fccc8c8a3b10ccdea608569a202c06@54.157.35.210:26656,f3f21c82c04003e3c6ee14eb4d11d5dd0b1f201e@107.20.250.182:26656"`.
* `DELIVERY_ETH_RPC_URL` — eth rpc url. Example: `DELIVERY_ETH_RPC_URL=https://mainnet.infura.io/v3/<YOUR_INFURA_KEY>`.

* `DELIVERY_FULL_NODE_SNAPSHOT_FILE` — fullnode snapshot file name of delivery. Example: `DELIVERY_FULL_NODE_SNAPSHOT_FILE="delivery-mainnet-snapshot-2022_03_03.tar.gz"`.
* `BTTC_ARCHIVE_NODE_SNAPSHOT_FILE` — fullnode snapshot file name of bttc. Example:`BTTC_FULL_NODE_SNAPSHOT_FILE="bttc-mainnet-snapshot-2022_03_03.tar.gz"`.
* `DELIVERY_ARCHIVE_NODE_SNAPSHOT_FILE` — fullnode snapshot file name of delivery. Example: `DELIVERY_ARCHIVE_NODE_SNAPSHOT_FILE="delivery-mainnet-snapshot-2022_03_03.tar.gz"`.
* `BTTC_ARCHIVE_NODE_SNAPSHOT_FILE` — fullnode snapshot file name of bttc. Example:`BTTC_ARCHIVE_NODE_SNAPSHOT_FILE="bttc-mainnet-snapshot-2022_03_03.tar.gz"`.
* `BTTC_TAG` — latest bttc release tag.make sure this tag should be same as your bttc docker images version mentioned above.  Example: `BTTC_TAG=v1.0.1`.
* `BTTC_MODE=` — bttc node mode.By default, full mode is enabled in .env files. To start archive node, set BTTC_MODE=archive
. Example: `BTTC_MODE="full"`.  



4.For setting up nodes:
```
docker-compose -f bttc-sentry-without-snapshotting.yml --env-file <env-file> up
```
Example(use snapshots,in mainnet):
```
docker-compose -f bttc-sentry-with-snapshotting.yml --env-file mainnet-199.env up
```

Example(do not use snapshots,in testnetnet):
```
docker-compose -f bttc-sentry-without-snapshotting.yml --env-file testnet-1029.env up
```

Example(do not use snapshots,in mainnet):
```
docker-compose -f bttc-sentry-without-snapshotting.yml --env-file mainnet-199.env up
```

Example(use snapshots,in testnetnet):
```
docker-compose -f bttc-sentry-with-snapshotting.yml --env-file testnet-1029.env up
```

Note - If your docker-compose doesn't support `--env-file` flag, then copy testnet-1029.env/mainnet-199.env to `.env` and run the following command


5.For checking the status of delivery use the following api
```
http://localhost:26657/status
```