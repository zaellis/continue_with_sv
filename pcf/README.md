# PCF files
PCF or Physical Constraint Format files are a mapping between the I/O of the top file in an FPGA project and the physical I/O of the FPGA chip itself. Depending on the software being used to parse the PCF and/or the FPGA architecture itself, the PCF file may also contain other I/O specific information like pullup/pulldown resistance. Overall I have found PCF files the hardest thing to find for an FPGA board (at least open source / community designed boards), so this portion of the repository is dedicated to files for various boards I have come across.

## Catalog
- tinyfpga_bx.pcf
    - for TinyFPGA BX board
    - tested and working
- icestick.pcf
    - for Lattice iCEstick evaluation kit
    - untested but seems to be correct