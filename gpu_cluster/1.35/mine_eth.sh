#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=eth.2miners.com:2020
WALLET=0x6cA39bC556132d3880651A3e6c9a5858a615E64D.worker

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo ETHASH --pool $POOL --mode LHR2 --user $WALLET $@
while [ $? -eq 42 ]; do
    sleep 10s
    ./lolMiner --algo ETHASH --pool $POOL --mode LHR2 --user $WALLET $@
done
