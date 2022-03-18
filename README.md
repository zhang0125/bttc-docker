This readme is for setting up full nodes/sentry nodes for BTTC network using docker-compose


## 0. Prerequisites

make sure install docker & docker-compose first, and we will recommended docker-compose version below:
```
docker-compose version 1.29.1, build c34c88b2
docker-py version: 5.0.0
CPython version: 3.9.0
OpenSSL version: OpenSSL 1.1.1h  22 Sep 2020
```


## 1. Build images

Make sure you use the lastest released version on Git([delivery release page](https://github.com/bttcprotocol/delivery/releases) & [bttc release page](https://github.com/bttcprotocol/bttc/releases)).

```
sh images-build.sh $BTTC_VERSION $DELIVERY_VERSION

```
Example:
```
sh images-build.sh v1.0.1 v1.0.0
```


## 2. Configuration
Run the following commands for local volumes to be mounted in docker-compose file
```
mkdir -p delivery/scripts

mv delivery-startup.sh delivery/scripts
```

Modify the env file. 

**Mainnet**

Open for editing `vim mainnet-199.env`:
* #`DELIVERY_TAG` — lastest delivery release tag,make sure this tag should be same as your delivery docker images version mentioned above.
* `DELIVERY_TAG=v1.0.0`
* #`DELIVERY_SEEDS` — seeds to sync from delivery fullnodes.
* `DELIVERY_SEEDS="161c2cbe07fccc8c8a3b10ccdea608569a202c06@54.157.35.210:26656,f3f21c82c04003e3c6ee14eb4d11d5dd0b1f201e@107.20.250.182:26656"`
* #`BTTC_TAG` — latest bttc release tag.make sure this tag should be same as your bttc docker images version mentioned above. 
* `BTTC_TAG=v1.0.1`

**Testnet**

Open for editing `vim testnet-1029.env`:
* #`DELIVERY_TAG` — lastest delivery release tag,make sure this tag should be same as your delivery docker images version mentioned above. 
* `DELIVERY_TAG=v1.0.0`
* #`DELIVERY_SEEDS` — seeds to sync from delivery fullnodes. 
* `DELIVERY_SEEDS="3f562eed0fcfabc848db5ebed81633e340352c0c@52.53.72.234:26656,7ece43f437d4dc419bdf9c09604ebed084699779@54.215.2.221:26656"`
* #`BTTC_TAG` — latest bttc release tag.make sure this tag should be same as your bttc docker images version mentioned above.  
* `BTTC_TAG=v1.0.1`

## 3. Run a node
 
```
docker-compose -f docker_compose_file --env-file <env-file> up
```

Example(mainnet):
```
docker-compose -f bttc-sentry-without-snapshotting.yml --env-file mainnet-199.env up
```
Example(testnet):
```
docker-compose -f bttc-sentry-without-snapshotting.yml --env-file testnet-1029.env up
```

## 4. Run a node with snapshot 

If you want to use snapshots file to accelerate sync,download the latest snapshots from [ BTTC Chains Snapshots](https://snapshots.bt.io/).

Example:
```
wget -c https://bttc-blockchain-snapshots.s3-accelerate.amazonaws.com/bttc-mainnet/2022_03_15/bttc-mainnet-snapshot-2022_03_15.tar.gz
wget -c https://bttc-blockchain-snapshots.s3-accelerate.amazonaws.com/bttc-mainnet/2022_03_15/delivery-mainnet-snapshot-2022_03_15.tar.gz
```
then execute follow commands.
```
mkdir -p bttc/snapshot
mkdir -p delivery/snapshot
mv <path-to-delivery-snapshot-file> delivery/snapshot
mv <path-to-bttc-snapshot-file> bttc/snapshot
```
Note - please make sure to download the snapshot files to the right place.


Open for editing `vim mainnet-199.env`:
* #`DELIVERY_FULL_NODE_SNAPSHOT_FILE` — fullnode snapshot file name of delivery.
* `DELIVERY_FULL_NODE_SNAPSHOT_FILE="delivery-mainnet-snapshot-2022_03_15.tar.gz"`
* #`BTTC_FULL_NODE_SNAPSHOT_FILE` — fullnode snapshot file name of bttc.
* `BTTC_FULL_NODE_SNAPSHOT_FILE="bttc-mainnet-snapshot-2022_03_15.tar.gz"`

start up node(mainnet):
```
docker-compose -f bttc-sentry-with-snapshotting.yml --env-file mainnet-199.env up
```


## 5. Checking
For checking the status of delivery use the following api
```
http://localhost:26657/status
```