#!/bin/bash

sudo service gdm stop
sudo pkill X
sudo X &
export DISPLAY=:0
sudo nvidia-smi -i 0 -lgc 1100
sudo nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[4]=2500
sudo pkill X
