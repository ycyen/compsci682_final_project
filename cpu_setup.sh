# System requirement Ubuntu 16.04
#
# Instruction
# 	- Please replace user below
#	- bash cpu_setup.sh
#	- manually copy and paste lines in maual.txt (for vim)
#
# Packages to be installed
# 	- python / pip / tmux / vim / CUDA (optional) / opencv / python APIs 
# 	- LSUN dataset (sheep / airplane) / SVHN dataset
#
# Notification:
# 	- For cpu version, comment out CUDA section and 
#	  switch from tensorflow-gpu==1.8.0 to tensorflow==1.8.0 in requirement.txt
#	- choose a section between progressiveGAN and label refinery
#	  depending on the project you're working on  


user=wonho

cwd=$(pwd)
set -x
set -e

## Update apt-get
sudo apt-get update
sudo apt-get -y --allow-unauthenticated upgrade

#################### Python & Pip ####################

## install pip (update it later in virtualenv) and virtualenv
sudo apt-get -y install python-dev
sudo apt-get -y install python3-dev

cd ~
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo python2 get-pip.py
sudo -H pip install virtualenv
rm get-pip.py 

#################### Tmux & Vim ####################

## install dot file
git clone --recursive https://github.com/wookayin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && python install.py

## install powerline
sudo apt-get install -y fonts-powerline

## install vim(python)
## notice that you need to manually run some related update-alternatives. Please refer to manual.txt 
sudo apt install -y vim-gtk

#################### CUDA ####################

# # install cud9.0 and cunn7.0
# cd ~
# wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
# wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
# wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb
# wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libnccl2_2.1.4-1+cuda9.0_amd64.deb
# wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/libnccl-dev_2.1.4-1+cuda9.0_amd64.deb
# sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
# sudo dpkg -i libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb
# sudo dpkg -i libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb
# sudo dpkg -i libnccl2_2.1.4-1+cuda9.0_amd64.deb
# sudo dpkg -i libnccl-dev_2.1.4-1+cuda9.0_amd64.deb
# sudo apt-get update
# sudo apt-get install -y --allow-unauthenticated cuda=9.0.176-1
# sudo apt-get install -y libcudnn7-dev
# sudo apt-get install -y libnccl-dev

# # recommend to reboot (if cuda doesn't work, do 'source .bashrc' again after rebooting)
# cd ~
# echo export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}} >> .bashrc
# echo export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} >> .bashrc
# source .bashrc

# rm cuda-repo-ubuntu1604_9.0.176-1_amd64.deb \
# 	libcudnn7_7.0.5.15-1+cuda9.0_amd64.deb \
# 	libcudnn7-dev_7.0.5.15-1+cuda9.0_amd64.deb \
# 	libnccl2_2.1.4-1+cuda9.0_amd64.deb \
# 	libnccl-dev_2.1.4-1+cuda9.0_amd64.deb

#################### Opencv 3.4.1 ####################

# Install opencv 3.4.1

## setup the version
cd ~
cvVersion="3.4.1"

mkdir installation
mkdir installation/OpenCV-"$cvVersion"


## Install dependencies
sudo apt-get update
sudo apt-get -y --allow-unauthenticated upgrade

sudo apt -y remove x264 libx264-dev
sudo apt -y install build-essential checkinstall cmake pkg-config yasm
sudo apt -y install git gfortran
sudo apt -y install libjpeg8-dev libjasper-dev libpng12-dev
 
sudo apt -y install libtiff5-dev
 
sudo apt -y install libtiff-dev
 
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev
cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd ~
 
sudo apt -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils
 
## Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

## Install some python packages (dependencies)
sudo -H pip install numpy scipy matplotlib scikit-image scikit-learn ipython
sudo -H pip3 install numpy scipy matplotlib scikit-image scikit-learn ipython

## Download openv and opencv_contrib
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $cvVersion
cd ..
 
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $cvVersion
cd ..

cd opencv
mkdir build
cd build

sudo cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..

sudo make -j4
sudo make install

## remove useless files
cd ~
sudo rm -rf opencv opencv_contrib installation


#################### Python packages ####################

## install python packages
cd $cwd
sudo -H pip install -r cpu_requirements.txt

## install some other packages
sudo apt-get -y install zip unzip

## some settings
cd ~/.config
mkdir matplotlib
cd matplotlib
echo "backend : Agg" >> matplotlibrc


######################## Projects ########################

#################### progressive GAN ####################

# ## clone repo (it requires github ID and password)
# cd ~
# git clone https://github.com/jhun0324/progressiveGAN.git

# ## dataset
# sudo mkdir /data
# sudo mkdir /data/LSUN
# sudo mkdir /data/LSUN/sheep /data/LSUN/airplane /data/LSUN/sheep_edge /data/LSUN/airplane_edge
# cd /data

# sudo wget http://tigress-web.princeton.edu/~fy/lsun/public/release/sheep.zip
# sudo wget http://tigress-web.princeton.edu/~fy/lsun/public/release/airplane.zip
# sudo unzip sheep.zip
# sudo unzip airplane.zip
# sudo rm sheep.zip
# sudo rm airplane.zip

# ## convert .webp to .jpg after resizing to 400x400
# cd ~/progressiveGAN
# sudo python data.py export /data/sheep/ --out_dir /data/LSUN/sheep/ --flat --size 400
# sudo python data.py export /data/airplane/ --out_dir /data/LSUN/airplane/ --flat --size 400

# ## create edge images
# sudo python preprocessing.py --data_dir /data/LSUN/sheep --output_dir /data/LSUN/sheep_edge
# sudo python preprocessing.py --data_dir /data/LSUN/airplane --output_dir /data/LSUN/airplane_edge

#################### Label Refinery ####################
cd ~
git clone https://github.com/jhun0324/labelRefineryDetection.git

## dataset
sudo mkdir /data
cd /data
sudo mkdir SVHN
cd SVHN

sudo wget http://ufldl.stanford.edu/housenumbers/train_32x32.mat
sudo wget http://ufldl.stanford.edu/housenumbers/test_32x32.mat
sudo wget http://ufldl.stanford.edu/housenumbers/extra_32x32.mat


