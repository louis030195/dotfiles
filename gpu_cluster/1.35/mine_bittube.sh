#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=mining.bittube.app:3400
WALLET=Tubed6kEh3gfJbdLRXMt7jDjJmqhKYpyPE2prL1JcbXhMm4xR7t2oo6ibYKAbJRgGoQvG6TMWG52deFxhwASoS3dd2jrVgwPWbU
WORKER=testWorker

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner -a CR29-40 --pool $POOL --user $WALLET --pass $WORKER $@
