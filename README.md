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
    * [Xilinx Vivado](#xilinx-vivado)
* [TODO](#todo)
## Goals
- Provide resources for developing in SystemVerilog with open source and/or free software
- Pull ideas from the community to improve my own development environment
- Increase awareness for development tools I enjoy using  
  
## Repository Contents
**[docs](https://github.com/zaellis/continue_with_sv/tree/main/docs)**: documentation on the installation procedure of recommended software and related notes  
  
**[helper_files](https://github.com/zaellis/continue_with_sv/tree/main/helper_files)**: extra files I have created to run different software smoothly  
  
**[examples](https://github.com/zaellis/continue_with_sv/tree/main/examples/)**: example projects using this software and hopefully a variety of FPGA boards  
  
**[pcf](https://github.com/zaellis/continue_with_sv/tree/main/pcf)**: example pcf (Physical Constraint Format) files for different FPGA boards that you might use. I have found tracking these down very difficult a lot of the time  
  
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
> More information on usage can be found in the [README](https://github.com/zaellis/continue_with_sv/tree/main/examples/alchitry_cu/base#getting-alchitry-loader-compiled) in `examples/alchitry_cu/base`  
  
The Alchitry Loader can be used to flash the Alchitry family of FPGA dev boards. It will either need to be compiled before use, or downloaded as a precompiled binary.
#### IceProg
> from the Project Icestorm [website](http://www.clifford.at/icestorm/)  
  
A small driver program for the FTDI-based programmer used on the iCEstick and HX8K development boards.  
It might also be possible to use this as a generic programmer for similar iCE40 dev boards / custom dev boards. Let me know if you have any success :)
### Xilinx Vivado
Vivado is Xilinx's all in one IDE for their FPGA products. It can be incredibly powerful and supports a lot of functionality that I have no knowledge of. I only use one of Vivado's features which is the simulation engine and waveform viewer. I will discuss some other FOSS alternatives to Vivado in the next section, but first I will explain why I use it for my SystemVerilog development and what I think it provides.
#### Full Language Support
Unfortunately at this point in time, in terms of FOSS tools, development is exclusively SystemVerilog is both a blessing and a curse. SystemVerilog is a very powerful language for both hardware description and simulation, however the complexities and features it brings are not always supported by every tool. Xilinx being a major player in the FPGA space however, does have the resources to integrate SystemVerilog language support into their IDE. The biggest reason I choose to use Vivado for simulation is the fact that it allows me to continue writing my testbenches how I was taught in ECE337 at Purdue, and it replicates the environment of QuestaSim fairly well.
#### Ease of Use (*)
Luckily for those of you who take advantage of this repository, I have spent countless hours pouring over the [Vivado Tcl Command Reference Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_1/ug835-vivado-tcl-commands.pdf) to try and create a very smooth workflow for those choosing Vivado to simulate Lattice iCE40 based designs. While I don't think my script is all encompassing and I am always looking to improve it, I think it does a great job of turning the mess of project / workspace setup and compiling it all into one command. I am also very happy to see that it can also do post-synthesis simulation for more realistic final verification. But enough tooting my own horn, I'm sure someone who actually knows how to write Tcl could put my script to shame.
#### Free (*)
While the full version of Vivado is not free, Vivado webpack is. In terms of my needs as a simulation platform, not needing to take advantage of Xilinx specific tools, I haven't run into any roadblocks in terms of performance
#### Cons of Using Vivado
Like any piece of software there will always be downsides. In terms of Vivado I only have a few gripes. The first is that you are required to download specific packages for at least one Xilinx FPGA architecture when you do your initial Vivado download. This adds the majority of the files and space that the IDE takes up on your disk. I would recommend checking each option during the download process to select the smallest option (I think in total it came to around 30GB). Secondly there is the fact that Vivado is proprietary / closed source. It is possible that the free Vivado webpack will not always be available, and free licenses may be revoked. I hope soon there will be FOSS simulation software with full SystemVerilog support.

## TODO
- Finish software briefs
    - other sim options / limitations
- write all in one install script / document installation commands
- validate POR module (reset_gen.sv) is really the best method
- add example projects and pcf files for more boards
- add information to the further reading section
