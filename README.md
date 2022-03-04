This readme is for setting up full nodes for testnet-1029 node for bttc network using docker-compose

Download the latest snapshot for testnet-1029 full node
```
wget -c hhttp://bttc-blockchain-snapshots.s3.amazonaws.com/bttc-testnet/2022_03_02/bttc--snapshot-2022_03_02.tar.gz?AWSAccessKeyId=AKIA4Y34TXGOMRJKLB5R&Expires=1646713138&Signature=JBvZD5g%2FwN3OFfyFScyDIAsOGfE%3D
wget -c http://bttc-blockchain-snapshots.s3.amazonaws.com/bttc-testnet/2022_03_02/delivery--snapshot-2022_03_02.tar.gz?AWSAccessKeyId=AKIA4Y34TXGOMRJKLB5R&Expires=1646713138&Signature=8mMepWfczN8qRDd57RfbCgfhWfc%3D
```

Note - If you are using different snapshot files, make changes for file names accordingly in the env files. We periodically take new snapshots and will publish new links.

By default, archive mode is enabled in .env files. To start full node, set BTTC_MODE=full

Recommended docker-compose version
```
docker-compose version 1.29.1, build c34c88b2
docker-py version: 5.0.0
CPython version: 3.9.0
OpenSSL version: OpenSSL 1.1.1h  22 Sep 2020
```


1.build bttc/delivery images locally
```
sh images-build.sh

```

2.Run the following commands for local volumes to be mounted in docker-compose file
```
#mkdir -p delivery/snapshot
mkdir -p delivery/scripts
#mkdir -p bttc/snapshot
#mv <path-to-delivery-snapshot-file> delivery/snapshot
#mv <path-to-bttc-snapshot-file> bttc/snapshot
mv delivery-startup.sh delivery/scripts
```

3.For setting up nodes:
```
docker-compose -f bttc-sentry-without-snapshotting.yml --env-file <env-file> up
```

If your docker-compose doesn't support `--env-file` flag, then copy testnet-1029.env/mainnet-199.env to `.env` and run the following command


4.For checking the status of delivery use the following api
```
http://localhost:26657/status
```