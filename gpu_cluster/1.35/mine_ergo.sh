#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=de.ergo.herominers.com:1180
WALLET=9i9m9AxmqgBUBD6GfYJQHZiHQ5d6AP7Ak3QVFfKiNtopQnMZkmG.lolMinerWorker

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo AUTOLYKOS2 --pool $POOL --user $WALLET $@
while [ $? -eq 42 ]; do
    sleep 10s
    ./lolMiner --algo AUTOLYKOS2 --pool $POOL --user $WALLET $@
done
