#!/bin/bash

# Clone the repository
git clone https://github.com/alchitry/alchitry-loader

# Let the user know warnings are okay
echo Don\'t worry about the warnings. I promise they\'re nothing... Pinky promise
echo Please make sure to install the d2xx drivers here: https://ftdichip.com/drivers/d2xx-drivers/

# Start the install
cd alchitry-loader/src
g++ -o alchitry_loader *.cpp -lftd2xx