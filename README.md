# continue_with_sv
Software and resources to help Purdue students (and others) continue developing with SystemVerilog after losing access to proprietary tools.
  
## Goals
- Provide resources for developing in SystemVerilog with open source and/or free software
- Pull ideas from the comunity to improve my own development environment
- Increase awareness for development tools I enjoy using  
  
## Repository Contents
**docs**: documentation on the instalation procedure of recommended software and related notes  
helper_files: extra files I have created to run different software smoothly  
  
**examples**: example projects using this software and hopefully a variety of FPGA boards  
  
**pcf**: example pcf (Physical Constraint Format) files for different FPGA boards that you might use. I have found tracking these down very difficult a lot of the time  
  
**further_reading**: topics that are an extension of what is included here but are not necessary for standard development. Can also be random catalog of cool stuff.  
  
## Software Briefs
Descriptions of different software utilized and some other noteworthy software that I think could be useful depending on usecase.  
  
### Yosys
Yosys is open source synthesis software. Its purpose is to transform the high level description (Verilog/SystemVerilog/VHDL/etc.) into a gate level representation of that high level description. Yosys mainly acts as a wrapper of the synthesis tool ABC (or your tool of choice), automatically running the neccesary synthesis passes for your design.  
More information about Yosys can be found on its Github repo:
- https://github.com/YosysHQ/yosys  
   
As well as the Yosys website:
- http://www.clifford.at/yosys/
## TODO
- Finish software briefs
    - nextpnr / arachnepnr
    - project icestorm
    - tinyprog / programmers
    - Vivado for sim
    - other sim options / limitations
- write all in one install script / document installation commands
- validate POR module (reset_gen.sv) is really the best method
- finish example project