#!/usr/bin/env bash

#################################################################################
# Bash Script to automate downloading most of the tools. Namely project icestorm
# yosys and nextpnr. A little bit of directory and environment setup is also done
#################################################################################

#This is working at the moment but there is still more to be desired for me...

#location where this Github repo is downloaded
CURR_DIR=$(pwd)

#nail down install location
cd ~
mkdir -p FPGA_Dev
cd FPGA_Dev

#project icestorm tools
if [ ! command -v icepack &> /dev/null ]
then
    sudo apt-get install build-essential clang bison flex libreadline-dev \
                        gawk tcl-dev libffi-dev git mercurial graphviz   \
                        xdot pkg-config python python3 libftdi-dev \
                        qt5-default python3-dev libboost-all-dev cmake libeigen3-dev

    git clone https://github.com/YosysHQ/icestorm.git icestorm
    cd icestorm
    make -j$(nproc)
    sudo make install
    cd .. #Just to make sure you return to where you started
fi

#nextpnr for iCE40 devices
if [ ! command -v nextpnr-ice40 &> /dev/null ]
then
    git clone https://github.com/YosysHQ/nextpnr.git nextpnr
    cd nextpnr
    cmake . -DARCH=ice40
    make -j$(nproc)
    sudo make install
    cd .. #Just to make sure you return to where you started
fi

#yosys
if [ ! command -v yosys &> /dev/null ]
then
    git clone https://github.com/YosysHQ/yosys.git yosys
    cd yosys
    make -j$(nproc)
    sudo make install
    cd .. #Just to make sure you return to where you started
fi

#setting up enviroment
#probably could narrow down search to the tools directory but I'm paranoid
VIVADO_SETUP=$(sudo find / -name settings64.sh 2> /dev/null | grep Vivado)

if [ ${#VIVADO_SETUP} -eq 0 ]
then
    echo "Vivado environment setup not detected. If you decide to install Vivado run this again"
else
    #make sure not to bloat .bashrc too much (Hopefully this works)
    command -v vivado || echo "source ./$VIVADO_SETUP" >> ~/.bashrc
fi

#copy useful files for every project to a known location
cp -r $CURR_DIR/helper_files/makefile .
cp -r $CURR_DIR/helper_files/reset_gen.sv .
cp -r $CURR_DIR/helper_files/vivado_manage.tcl .

#make sure not to bloat .bashrc too much (Hopefully this works)
cat ~/.bashrc | grep setup_FPGA &> /dev/null || echo -e "function setup_FPGA(){\n \
    \techo copying base files...\n \
    \tcp -r ~/FPGA_Dev/makefile .\n \
    \tcp -r ~/FPGA_Dev/reset_gen.sv .\n \
    \tcp -r ~/FPGA_Dev/vivado_manage.tcl .\n \
    \tchmod +x makefile\n \
    \techo setting up directory structure...\n \
    \tmkdir -p intermediate\n \
    \tmkdir -p logs\n \
    \tmkdir -p mapped\n \
    \techo done\n \
}" >> ~/.bashrc

CELL_FILE=$(find ~/FPGA_Dev/yosys/ -name cells_sim.v | grep ice40)

#need to figure out how to insert this into the makefile
#I can do it I'm just lazy

source ~/.bashrc
reset
