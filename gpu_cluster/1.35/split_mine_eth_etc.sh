#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

ETHPOOL=eu1.ethermine.org:4444
ETHWALLET=0x155da78b788ab54bea1340c10a5422a8ae88142f.lolMinerWorker

ETCPOOL=etc.2miners.com:1010
ETCWALLET=0x155da78b788ab54bea1340c10a5422a8ae88142f.lolMinerWorker

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo ETHASH --pool $ETHPOOL --user $ETHWALLET --dualmode etc --dualpool $ETCPOOL --dualuser $ETCWALLET $@
