#!/bin/bash

sudo service gdm stop
sudo pkill X
sudo X &
export DISPLAY=:0
sudo nvidia-smi -i 0 -lgc 1700
sudo nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[4]=0
