#Setup
> Don't worry about what you see here for now. These will eventually make sense  

```
source /tools/Xilinx/Vivado/2020.2/settings64.sh
```
  
```
function setup_FPGA(){
    echo copying base files...
    cp -r ~/Documents/FPGA_dev/makefile .
    cp -r ~/Documents/FPGA_dev/pins.pcf .
    cp -r ~/Documents/FPGA_dev/reset_gen.sv .
    cp -r ~/Documents/FPGA_dev/vivado_manage.tcl .
    chmod +x makefile
    echo setting up directory structure...
    mkdir -p intermediate
    mkdir -p logs
    mkdir -p mapped
    echo done
}
```