# Installation Instructions
I recommend installing everything in a directory somewhere you will remember. Lots of these repositories contain good examples of their own and also contain files referenced by the makefile. For board specific tools like loaders I recommend checking the examples portion of this repository for more specific information. It is possible that some boards may support iceprog in which case nothing else is needed. 

```
#################################################################################
# You can basically copy this all into a bash script and run as sudo. However I 
# leave this here if you like to do things by hand
#################################################################################

#project icestorm tools
sudo apt-get install build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev \
                     qt5-default python3-dev libboost-all-dev cmake libeigen3-dev

git clone https://github.com/YosysHQ/icestorm.git icestorm
cd icestorm
make -j$(nproc)
sudo make install
cd .. #Just to make sure you return to where you started

#nextpnr for iCE40 devices
git clone https://github.com/YosysHQ/nextpnr.git nextpnr
cd nextpnr
cmake . -DARCH=ice40
make -j$(nproc)
sudo make install
cd .. #Just to make sure you return to where you started

#yosys
git clone https://github.com/YosysHQ/yosys.git yosys
cd yosys
make -j$(nproc)
sudo make install
cd .. #Just to make sure you return to where you started
```