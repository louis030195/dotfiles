#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=btg.2miners.com:4040
WALLET=GcK4pcrrkm8dWHynmycC7bJJVrWzf7mk8T.workerName
ALGO=EQUI144_5
PERSONALIZATION=BgoldPoW

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner -a $ALGO --pers $PERSONALIZATION --pool $POOL --user $WALLET $@
