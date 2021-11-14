#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=ae.2miners.com:4040
WALLET=ak_aQtZcwia4WuD2J8aQFFB44eNto7QoBERFKBinzZcqxoojRBNo.WorkerName

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner -a C29AE --pool $POOL --user $WALLET $@
