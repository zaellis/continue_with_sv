# Alchitry CU Base Example

The Alchitry CU is a simple FPGA development board designed by SparkFun around the iCE40-HX8K FPGA. It's designed to be similar to Arduino in ease of use
with open source software supporting development in both Verilog and Lucid (a HDL created by SparkFun to be easy to learn). SparkFun also sells an IO board
with 4 7 segment displays, 5 buttons, 3 sets of 8 LEDs, and 3 DIP switches with 8 switches per as well as a development board for soldering your own circuitry.
These boards are quite capable
for their size, but requirements of using iCEcube2 and Alchitry Labs hold development back quite a bit. System Verilog isn't supported by default, which
would nullify the aim of this repository. If you want to use this board, you can take the easy route with the given software (do note that it might not
work as well as they claim!) and never touch System Verilog. Or, better yet, using Yosys, project IceStorm, Arachne/Next-pnr, and Vivado, we can write,
verify, and load System Verilog based creations onto the CU.

## Table of contents

* [Roadmap](#roadmap)
* [Getting started](#getting-started)
* [D2XX installation](#getting-d2xx-installed)
* [Alchitry Loader installation/compilation](#getting-alchitry-loader-compiled)
* [Compiling the project](#compiling-the-project)
* [Flashing the CU](#flashing-the-cu)

## Roadmap

- [x] Simple makefile
- [x] Alchitry Loader install script
- [x] Simple example
- [x] Readme
- [ ] Full PCF for Alchitry IO
- [ ] Testbench synthesis
- [ ] Extended makefile
- [ ] Vivado integration
- [ ] Forking of Alchitry Loader

## Getting started

This example is built with Linux in mind. It'll also work on MacOS, but Windows has not and will not be tested. You'll need to install the following tools
for use:

* [IceStorm Tools](http://www.clifford.at/icestorm/)
* [Arachne-PNR](http://www.clifford.at/icestorm/)
* [Yosys](http://www.clifford.at/icestorm/)
* [D2XX FTDI Drivers](https://ftdichip.com/drivers/d2xx-drivers/)
* [Alchitry Loader](https://github.com/alchitry/alchitry-loader) (can be downloaded from GitHub release 0.1)

Installation for the first three is trivial; the bash commands given will do the trick. D2XX, not so much.

### Getting D2XX installed

The Alchitry CU uses an FTDI IC (similar to what is used in the UART lab during ECE 362) to communicate via USB. Unfortunately, the drivers need manual installation
to work, and the Alchitry Loader tool cannot be compiled without the libraries being installed. To do so, navigate to the link given above. Download the package
that suits your system the best. Then, click (installation guides)[https://ftdichip.com/document/installation-guides/] and find the guide for the OS that suits you.
If you are using Linux, there is an extra step that is crucial to proper operation of the Alchitry Loader. You'll be able to compile it without this, but you won't
be able to run the app without doing this.

Type `echo $LD_LIBRARY_PATH`. This will output the current path to installed libraries. If nothing returns, your default library path variable likely isn't set.
To do so, type `LD_LIBRARY_PATH=/usr/local/lib` to ensure the library path is up to date. Then, and this is the most important step, type `sudo ldconfig` and enter
your password. This will configure the installed libraries and allow the Alchitry Loader to use them. We'll get the loader installed next.

### Getting Alchitry Loader compiled

To get Alchitry Loader running, you have two options: build from source (recommended) or download release 0.1 from GitHub. The release contains a compiled binary
as well as the source code in a tar.xz archive. You can download this and stick the loader in with the project files for easy access. The other, and more
preferable approach is to use the given install script to clone the source code and compile the source locally. To do this, clone this repository, give execute
permissions to `install.sh` using `sudo chmod +x install.sh` and execute the install script using `./install`. This script will clone the repo, cd in, and
compile the source using g++ and the D2XX library we installed above. If you don't have the drivers/library installed at this point, you'll get a compilation error.
If you do, you'll get compilation warnings (~70), but they don't impact operation from what's been observed to this point. More information on using the loader will
follow.

There is another option, but I haven't gotten it to work once. You can install Alchitry Tools from the Alchitry site and use the graphical loader. For me, it has
hung on starting every single time, so I started using the cli.

### Compiling the project

Use `make all` to compile the project (I wasn't kidding when I said the makefile was simple at the top). Type `make clean` to remove intermediate synthesis files
and output binary. Yosys should be called with arachne-pnr following. Then, IceExplain will generate a few more files with IcePack finishing mapping to a binary
file. IceTime can be added in to run a timing analysis if desired.

### Flashing the CU

This is where we use Alchitry Loader to flash the CU. Plug the CU into your PC (and make sure that it's connected to the correct OS if you're using a VM) and open
a terminal session. Use `./alchitry-loader` in the same directory as the application to call the loader. The arguments and their functions are listed below.

* `-e` Erase FPGA flash. You shouldn't use this with an Alchitry CU
* `-l` List detected boards. Use this to check proper connection to your CU as well as gather the device index for programming
* `-h` Prints help message. It's pretty much the same as what you're reading now and will be called if no arguments are passed in by default
* `-f` Write to FPGA flash. This is a non-volatile write and will persist after power-on-reset
* `-r` Write to FPGA RAM. This is a volatile write and will be cleared upon rebooting the device
* `-u` Write to FTDI EEPROM. I haven't investigated this yet. Use with caution
* `-b n` Directs the loader at a board at index n (gather index with `- l`)
* `-p` Bridge file input. Don't use with the CU
* `-t` Board type. Can be either `au` or `cu`, but defaults to au

So, flashing should look like this. Run `./alchitry-loader -l` and figure out which index your board is. Then use `./alchitry-loader -b n -t cu -f cu.bin` to flash
the CU.

> If the Alchitry Loader binary and the .bin file are not in the same directory, you will need to use bash syntax to reference each location properly

If you compiled from source, using `./alchitry-loader -b n -t cu -f ../../cu.bin` will work.

You should now be able to press the reset button and see the LEDs change in accordance with an increasing binary value.
