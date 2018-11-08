#!/bin/bash

# System requirement Ubuntu 16.04
usr=mark

# install python3.6 and set to default
# kindly reference from https://stackoverflow.com/questions/42662104/how-to-install-pip-for-python-3-6-on-ubuntu-16-10
echo add PPA
sudo add-apt-repository ppa:jonathonf/python-3.6

echo sudo apt update
sudo apt update

echo sudo apt install python3.6
sudo apt install -y python3.6

echo sudo apt install python3.6-dev
sudo apt install -y python3.6-dev

echo sudo apt install python3.6-venv
sudo apt install -y python3.6-venv

echo install opencv dependency
sudo apt-get update
sudo apt-get install -y libsm6 libxext6
sudo apt-get install -y libgtk2.0-dev


echo download get-pip.py
wget https://bootstrap.pypa.io/get-pip.py

echo install get-pip.py
sudo python3.6 get-pip.py

echo create soft link
sudo ln -s -f /usr/bin/python3.6m /usr/bin/python
sudo ln -s -f /usr/local/bin/pip /usr/local/bin/pip3

echo remove downloaded package
rm -f get-pip.py

echo check python version
python --version

echo check pip version
pip --version

echo
echo Done python install !!!
echo

# install package
sudo pip install pygame
sudo pip install torch
sudo pip install numpy
sudo pip install matplotlib
sudo pip install opencv-python
