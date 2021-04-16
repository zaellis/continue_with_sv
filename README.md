# continue_with_sv
Software and resources to help Purdue students (and others) continue developing with SystemVerilog after losing access to proprietary tools.
  
## Goals
- Provide resources for developing in SystemVerilog with open source and/or free software
- Pull ideas from the community to improve my own development environment
- Increase awareness for development tools I enjoy using  
  
## Repository Contents
**docs**: documentation on the installation procedure of recommended software and related notes  
helper_files: extra files I have created to run different software smoothly  
  
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

## TODO
- Finish software briefs
    - project icestorm
    - tinyprog / programmers
    - Vivado for sim
    - other sim options / limitations
- write all in one install script / document installation commands
- validate POR module (reset_gen.sv) is really the best method
- add example projects and pcf files for more boards