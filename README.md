# continue_with_sv
Software and resources to help Purdue students (and others) continue developing with SystemVerilog after losing access to proprietary tools.
  
## Table of Contents
* [Goals](#goals)
* [Repository Contents](#repository-contents)
* [Installation](#installation)
* [Software Briefs](#software-briefs)
    * [Yosys](#yosys)
    * [nextpnr / arachnepnr](#nextpnr-/-arachnepnr)
    * [Project Icestorm](#project-icestorm)
    * [Loading Programs](#loading-programs)
    * [Xilinx Vivado](#xilinx-vivado)
    * [Other Sim Options](#other-sim-options-/-limitations)
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

## Installation
All of these software can be installed manually and individually using instructions from their documentation or based on the commands outlined in the [docs section](https://github.com/zaellis/continue_with_sv/blob/main/docs/Install.md). Vivado is the only exception as installation is not done from the command line and can rather be started from this [link](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2020-3.html). For that I would recommend downloading the full design suite self extracting web installer (for linux hopefully), and selecting the `WebPACK` version (which is free). If you want to emulate the workflow presented in this repository and intend to be working mostly with Lattice iCE40 products (or on no physical hardware at all), I recommend just executing `install.sh` in the root directory of this repository by running the following commands.
```
#first clone the repository
git clone https://github.com/zaellis/continue_with_sv.git

#enter the repo folder created by the clone
cd continue_with_sv

#execute the install script as root
sudo ./install.sh
```
If you are planning to also download Vivado I would recommend doing so before running this install script, but if you don't or you download Vivado later you can just run the script for a second time.  
Not only does the install script install the important tools themselves, but it also does some directory and environment setup to make sure the use of these tools is as smooth as possible. As of now the following functionality is setup.
- add the setup_FPGA command which can be run every time you start a project in a new folder
    - sets up useful project directories
    - adds makefile, power on reset module, and Vivado tcl script to project folder
- allows the vivado command to be run from terminal without needing to run a separate script after startup
- stores files used in most projects in a base FPGA_dev directory
    - base makefile
    - power on reset module
    - vivado tcl script  
  
I would highly recommend using this install script if you would like to use the tools presented here and try out some of the examples in this repo as well.  
> Important note: Even if you have installed some of these tools previously I would still recommend this install script for the environment setup alone. The script has been configured such that it will not install software a user already has
  
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
### Other Sim Options / Limitations
This section is more of a listing of other FOSS simulations options and why I don't use them than an introduction to their capabilities. Unfortunately most of my knowledge on these tools is just that they are pretty good at what they do.
#### Icarus Verilog
Icarus Verilog is a pretty full featured FOSS simulation tool. It can be integrated with waveform viewers as well for good visuals. If you want more detailed information about this tool I recommend their [website](http://iverilog.icarus.com/) and [wiki](https://iverilog.fandom.com/wiki/Main_Page). There are a couple main reasons why I don't use Icarus Verilog. The first and most important is that the support of many SystemVerilog features (and a lot of those used in ECE337 at Purdue) are not supported by Icarus Verilog. Therefore the style of RTL code and testbench design that I was taught would need to be completely refactored for this tool which would be counter productive to my personal goal of increasing my design skills. I didn't want to have to start by finding workarounds for my testbenches. Secondly Icarus verilog uses an intermediate form between simulation and waveform viewing called `vvp assembly`. In order to be compliant with their workflow I would need to add waveform tracking to my testbench code itself. While this really isn't that big of a deal I was sure I would forget and this was also not something I has to deal with in Vivado or Questa. However if you are just starting out with Verilog/SystemVerilog development and would like to use FOSS tools for everything, Icarus Verilog would be my recommendation.
#### Verilator
Verilator is an advanced Verilog/SystemVerilog simulation tool which aims to reduce simulation time by compiling RTL into "Verilated" .ccp and .h files. This works much differently from most FOSS and commercial simulators that interpret the design and testbench files directly. As such, testbenches for Verilator are also written in C++ or SystemC so they can be run just as fast. Verilator supports both Verilog and SystemVerilog, but only the synthesizable subsets of these languages (things like assertions might also be supported but I'm not 100% sure). The reason I don't use Verilator is because my designs are not that large, and would not really take advantage of the increased simulation speed that it provides. I am also used to writing testbenches in SystemVerilog as opposed to C++/SystemC. However, in the future if I am working on a project that requires the power Verilator could provide it would be my top choice. More infor and documentation can be found in their [user guide](https://verilator.org/guide/latest/).
#### EDA playground
[EDA playground](https://www.edaplayground.com/home) is a web based simulation software that is often recommended to beginners or those who don't have the ability to support simulation software locally. It is a pretty capable tool and also integrates with EPWave for some basic waveform viewing as well. Some of the great things about EDA playground is that is supports full SystemVerilog, allows users to take advantage of a wide range of simulators including commercial ones like Mentor Questa (just without the UI), and can also support sharing of "playgrounds" between users and the public if that is desired. The reason I don't use EDA playground personally is mainly that I don't enjoy browser based tools. Additionally while EDA playground is very capable it can be difficult to create projects with multiple module files within the UI. Finally, EDA playground uses vvp assembly like Icarus Verilog as a go between simulation and waveform viewing that I think makes the experience less configurable on the fly. I would recommend this tool to people who are curious about RTL development and don't want to install a large number of software packages locally.

## TODO
- validate POR module (reset_gen.sv) is really the best method
- add example projects and pcf files for more boards
- add information to the further reading section
