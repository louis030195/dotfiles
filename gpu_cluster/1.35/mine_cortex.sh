#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=ctxc.2miners.com:2222
WALLET=0x10487aaa46daf9a19deccfccaa2c5dc80af4692c.WorkerName

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --coin CTXC --pool $POOL --user $WALLET $@
