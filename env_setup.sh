#!/bin/bash

usr=mark

echo "===  start install anaconda  ==="
### download anaconda setup script
### get latest verson from https://www.anaconda.com/download/#linux
cd ~
wget https://repo.anaconda.com/archive/Anaconda2-5.3.0-Linux-x86_64.sh
chmod +x Anaconda2-5.3.0-Linux-x86_64.sh
./Anaconda2-5.3.0-Linux-x86_64.sh
rm -rf Anaconda2-5.3.0-Linux-x86_64.sh
echo "==== done install anaconda ==="


# === install some python packages ===
conda install -c anaconda opencv
conda install pytorch-cpu torchvision-cpu -c pytorch
pip install pygame

