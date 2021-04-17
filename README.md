# continue_with_sv
Software and resources to help Purdue students (and others) continue developing with SystemVerilog after losing access to proprietary tools.
  
## Table of Contents
* [Goals](#goals)
* [Repository Contents](#repository-contents)
* [Software Briefs](#software-briefs)
    * [Yosys](#yosys)
    * [nextpnr / arachnepnr](#nextpnr-/-arachnepnr)
    * [Project Icestorm](#project-icestorm)
    * [Loading Programs](#loading-programs)
* [TODO](#todo)
## Goals
- Provide resources for developing in SystemVerilog with open source and/or free software
- Pull ideas from the community to improve my own development environment
- Increase awareness for development tools I enjoy using  
  
## Repository Contents
**docs**: documentation on the installation procedure of recommended software and related notes  
  
**helper_files**: extra files I have created to run different software smoothly  
  
**examples**: example projects using this software and hopefully a variety of FPGA boards  
  
**pcf**: example pcf (Physical Constraint Format) files for different FPGA boards that you might use. I have found tracking these down very difficult a lot of the time  
  
**further_reading**: topics that are an extension of what is included here but are not necessary for standard development. Can also be random catalog of cool stuff.  
  
## Software Briefs
Descriptions of different software utilized and some other noteworthy software that I think could be useful depending on use case.  
  
### Yosys
Yosys is open source synthesis software. Its purpose is to transform the high level description (Verilog/SystemVerilog/VHDL/etc.) into a gate level representation of that high level description. Yosys mainly acts as a wrapper of the synthesis tool ABC (or your tool of choice), automatically running the necessary synthesis passes for your design.  
More information about Yosys can be found on its Github repo:
- https://github.com/YosysHQ/yosys  
   
As well as the Yosys website:
- http://www.clifford.at/yosys/

### nextpnr / arachnepnr
nextpnr and arachnepnr are two open source FPGA place and route tools, with nextpnr being a more modern replacement for arachnepnr which is no longer being maintained. Place and route tools take output from synthesis software such as Yosys and allocate synthesized logic to predefined logic cells within the FPGA, once the placing is complete, the cells are then routed together and to the outside world. nextpnr can be compiled for specific FPGA architectures and is used in this repository for lattice iCE40 products.  
More information about nextpnr and arachnepnr can be found on their Github repos:
- https://github.com/YosysHQ/nextpnr
- https://github.com/YosysHQ/arachne-pnr

### Project Icestorm
Project Icestorm is an amalgamation of open source tools for development with Lattice iCE40 FPGAs. An overview and description can be found on both the Project Icestorm Github:  
https://github.com/YosysHQ/icestorm  
  
As well and the Project Icestorm website:  
http://www.clifford.at/icestorm/  
  
The two Project Icestorm tools used by in this repo are:
#### IcePack
The icepack program converts such an ASCII file back to an iCE40 .bin file. All other IceStorm Tools operate on the ASCII file format, not the bitstream binaries. 
#### IceTime
The icetime program is an iCE40 timing analysis tool. It reads designs in IceStorm ASCII format and writes times timing netlists that can be used in external timing analysers. It also includes a simple topological timing analyser that can be used to create timing reports.  
  
> These descriptions were taken from the Project Icestorm [website](http://www.clifford.at/icestorm/)

### Loading programs
Depending on what development board you are using, you will probably encounter a menagerie of different loading programs. It is also that loading the FPGA bitstream is done by whichever IDE you are using. A few will be described here.
#### tinyprog
tinyprog is the bitstream loader for the TinyFPGA family of development boards. These dev boards come pre-loaded with a custom bootloader which allows programming to be done directly from USB. This is convenient in that it avoids needing to use a USB to SPI converter for flash programming (see [issues with FTDI](https://arstechnica.com/information-technology/2014/10/ftdis-anti-counterfeiting-efforts-sit-between-a-rock-and-a-hard-place/)), or a custom cable, but is otherwise just a novelty. tinyprog is currently used in the `prog` target of the [standard makefile](https://github.com/zaellis/continue_with_sv/blob/main/helper_files/makefile) for this repo.
#### Alchitry Loader
> More information on usage can be found in the [README](https://github.com/zaellis/continue_with_sv/blob/main/examples/alchitry_cu_counter/readme.md) in `examples/alchitry_cu_counter/`  
  
The Alchitry Loader can be used to flash the Alchitry family of FPGA dev boards. It will either need to be compiled before use, or downloaded as a precompiled binary.
#### IceProg
> from the Project Icestorm [website](http://www.clifford.at/icestorm/)  
  
A small driver program for the FTDI-based programmer used on the iCEstick and HX8K development boards.  
It might also be possible to use this as a generic programmer for similar iCE40 dev boards / custom dev boards. Let me know if you have any success :)
## TODO
- Finish software briefs
    - Vivado for sim
    - other sim options / limitations
- write all in one install script / document installation commands
- validate POR module (reset_gen.sv) is really the best method
- add example projects and pcf files for more boards