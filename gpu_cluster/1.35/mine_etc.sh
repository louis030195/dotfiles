#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=etc.2miners.com:1010
WALLET=0x155da78b788ab54bea1340c10a5422a8ae88142f.lolMinerWorker

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo ETCHASH --pool $POOL --user $WALLET $@
