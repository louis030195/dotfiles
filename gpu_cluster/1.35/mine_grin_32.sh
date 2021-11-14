#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=asia-grin.2miners.com:3030
WALLET=2aHR0cHM6Ly9ncmluLmJpdG1lc2guY29tL3d1Q3BLeW5kVllZanFQQm1ldHRCNWJjMjE2.WorkerName
PASS=x

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner -a C32 --pool $POOL --user $WALLET --pass $PASS $@
