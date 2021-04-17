# TinyFPGA BX "heartbeat" example

The TinyFPGA BX is a small formfactor lightweight development board utilizing the iCE40-LP8k FPGA. It is designed by Luke Valenty and one of a few members of his TinyFPGA family. All TinyFPGA boards are open source and utilize a custom bootloader that allows programming directly from usb through the tinyprog tool. 

## Getting Started
The [TinyFPGA BX User Guide](https://tinyfpga.com/bx/guide.html) suggests using Atom and the APIO_IDE plugin for development. I think this could be a good option if you already use Atom, however in the reducing the number of IDEs you install, and in creating a solution that will work with many FPGA ecosystems this guide will focus on a different solution. Like many of the other dev boards introduced here, the following prerequisites are required:
- Project icestorm
    - icepack
    - icetime (optional)
- Yosys
- nextpnr
- Xilinx Vivado (optional)

A general install method for these resources should be eventually included in the root folder of this repo and/or in its own install script.  
The following is also required for using TinyFPGA specific boards
- tinyprog (for being able to load a bitstream through usb directly)  

tinyprog can be installed and updated like so  
```
pip install tinyprog
```
or if you have python 3.x  
```
pip3 install tinyprog
```
when you connect your FPGA board for the first time you should also run  
```
tinyprog --update-bootloader
```
in order to make sure everything is on the same version.  
Finally it may be necessary to add yourself to the dialout group in your os in order to be able to access serial ports
    sudo usermod -a -G dialout $USER
After that you should be able to use the provided makefile to compile, load, and simulate this example project.

## Notes on the Makefile
This is the general makefile that I personally use for working with TinyFPGA products. Most of the time only the **PROJ** and **COMPONENT_FILES** variables will needed to be changed. If you are using a new board for the first time, other variables such as **PIN_DEF**, **DEVICE**, and **PACKAGE** will need to be updated as well. I have added all the valid device and package names I could find as a helpful cheat sheet. Limited info about them can be found [here](http://www.clifford.at/icestorm/). Another Variable to keep in mind is **SIM_CELLS** but only if you want to do timing accurate simulations of your project (with Vivado in this case). The value entered there is the exact path on my computer but could be different depending on where you install yosys. However if you can locate your base yosys folder it shouldn't be hard to find (I'm hoping to eventually write a script to automate this process and then you won't need to worry). Aside from all of this I'm hoping the makefile, along with my tcl script for dealing with Vivado will help make this process simple and easy.

## "heartbeat" example
In the simplest terms this example lights up the user LED on the TinyFPGA BX in a "heartbeat" fashion by raising and lowering the brightness on approximately a 2 second period. It could also very easily be configured into an adjustable PWM module (although the main counter would need to be more sophisticated, I tried not to include something that could be user as a flex counter for ECE337).  
Included are: 
- top module containing the heartbeat logic 
    - [top.sv](https://github.com/zaellis/continue_with_sv/blob/main/examples/tinyfpga_bx_heartbeat/top.sv)
- power on reset module I use in all of my projects
    - [reset_gen.sv](https://github.com/zaellis/continue_with_sv/blob/main/examples/tinyfpga_bx_heartbeat/reset_gen.sv)
-  PCF file for the project
    - [tinyfpga_bx.pcf](https://github.com/zaellis/continue_with_sv/blob/main/examples/tinyfpga_bx_heartbeat/tinyfpga_bx.pcf)
- tcl script for setting up a project in Vivado and doing simulation
    - [vivado_manage.tcl](https://github.com/zaellis/continue_with_sv/blob/main/examples/tinyfpga_bx_heartbeat/vivado_manage.tcl)
- makefile
    - [makefile](https://github.com/zaellis/continue_with_sv/blob/main/examples/tinyfpga_bx_heartbeat/makefile)