#!/bin/bash

# 62 mhs 0.7% fee
./1.35/mine_eth.sh

# 64 mhs 0.8% fee
#./miner --algo ethash --server eth.2miners.com:2020 --user 0x6cA39bC556132d3880651A3e6c9a5858a615E64D

# 48mhs no fee
#./nsfminer -U -P stratum1+tcp://0x6cA39bC556132d3880651A3e6c9a5858a615E64D@eth.2miners.com:2020 | tee -a mining.log
