# Makefile inspired by https://github.com/cliffordwolf/icestorm/blob/master/examples/icestick/Makefile
#
# The following license is from the icestorm project and specifically applies to this file only:
#
#  Permission to use, copy, modify, and/or distribute this software for any
#  purpose with or without fee is hereby granted, provided that the above
#  copyright notice and this permission notice appear in all copies.
#
#  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#make sure these are filled in properly

PROJ :=
TOP_LEVEL_FILE := $(PROJ).sv
COMPONENT_FILES := reset_gen.sv
TESTBENCH := tb_$(PROJ).sv

TB_MODULE := $(notdir $(basename $(TEST_BENCH)))
TOP_MODULE := $(notdir $(basename $(TOP_LEVEL_FILE)))

PIN_DEF :=
DEVICE :=
PACKAGE :=

#Valid Devices and Corresponding Package Names
#Mostly Taken From: http://www.clifford.at/icestorm/
#Plus a Little Experimentation
#Your Mileage May Vary
#
#Device: lp384
#	Packages: cm36, cm49, qn32
#Device: lp1k
#	Packages: swg16tr, cm36, cm49, cm81, cm121, qn84, cb81, cb121
#Device: lp4k
#	Packages: cm81:4k, cm121:4k, cm225:4k
#Device: lp8k
#	Packages: cm81, cm121, cm225
#Device: hx1k
#	Packages: cb132, vq100, tq144
#Device: hx4k
#	Packages: cb132:4k, tq144:4k, bg121:4k
#Device: hx8k
#	Packages: cm225, cb132, bg121, ct256
#Device: u1k (ICE5LP1K or ICE40UL1K??? Best guess is the former)
#	Packages: sg48 (other possible packages not supported)
#Device: u2k (ICE5LP2k)
#	Packages: sg48 (other possible packages not supported)
#Device: up3k
#	Packages: uwg30
#Device: u4k (ICE5LP4k)
#	Packages: sg48 (other possible packages not supported)
#Device: up5k
#	Packages: uwg30, sg48
#
#Maybe More???!!!!?!?!??!??!!!?!?!?!?

#path to simulation cells for given FPGA tech (probably ice40)
#for ice40 through project icestorm the path is probably similar to
# ~/Documents/FPGA_dev/icestorm-build/yosys/techlibs/ice40/cells_sim.v
SIM_CELLS := 

SIM_LIBRARY := $(notdir $(SIM_CELLS))

help:
	@echo "----------------------------------------------------------------"
	@echo "Administrative targets:"
	@echo "  clean         - removes the intermediate files"
	@echo "  veryclean     - removes all generated files"
	@echo "  print_vars    - prints the contents of the variables"
	@echo
	@echo
	@echo "Build targets:"
	@echo " intermediate/%.json  - creates a json representation of the design "
	@echo "                        heirachy and connections in preparation for"
	@echo "                        place and route with the basename %. Routes "
	@echo "                        feedback to logs/<project name>_yosys.log"
	@echo " intermediate/%.asc   - creates an ASCII representation of the "
	@echo "                        placement and routing plan for the design"
	@echo "                        using basename %. Needed for timing analysis "
	@echo "                        and generation of the binary. Feedback is "
	@echo "                        routed to logs/<project name>_pnr.log"
	@echo " %.bin                - creates the binary for the entire project "
	@echo "                        with the basename of %"
	@echo " logs/%.rpt           - creates a timing report for the project with "
	@echo "                        the basename of %."
	@echo " all                  - runs logs/$(PROJ).rpt $(PROJ).bin"
	@echo " debug                - runs 'all' but in debug mode with output make_debug.txt"
	@echo
	@echo "Simulation targets:"
	@echo "  tbsim_source      - compiles and simulates the source version"
	@echo "                      of a full design including its top level"
	@echo "                      test bench"
	@echo "  tbsim_mapped      - compiles and simulates the mapped version "
	@echo "                      of a full design including its top level "
	@echo "                      test bench"
	@echo 
	@echo "Synthesis targets:"
	@echo "  mapped/%_syn.v - synthesizes the mapped version of the project. "
	@echo "                   Hopefully will provide accurate cell timing in "
	@echo "                   the future but is just used to verify the project "
	@echo "                   functions the same after yosys for now"
	@echo "----------------------------------------------------------------"

all: logs/$(PROJ).rpt $(PROJ).bin

debug:
	@echo "Running make in debug mode..."
	@$(MAKE) -d > make_debug.txt
	@echo "Done. See make_debug.text for debug output"

intermediate/%.json: $(TOP_LEVEL_FILE) $(COMPONENT_FILES)
	@mkdir -p intermediate/
	@mkdir -p logs/ 
	yosys -p 'synth_ice40 -top $(PROJ) -json $@' $^ -q -l logs/$(PROJ)_yosys.log

intermediate/%.asc: intermediate/%.json $(PIN_DEF)
	nextpnr-ice40 --$(DEVICE) --json $< --pcf $(PIN_DEF) --asc $@ --package $(PACKAGE) -q -l logs/$(PROJ)_pnr.log

%.bin: intermediate/%.asc
	icepack $< $@

logs/%.rpt: intermediate/%.asc
	icetime -d $(DEVICE) -mtr $@ $<

mapped/%_syn.v: intermediate/%.json
	@mkdir -p mapped/
	yosys -p 'read_json $<; write_verilog $@' -q

prog: $(PROJ).bin
	tinyprog -p $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo tinyprog -p $<

vivado/vivado_project.xpr:
	vivado -mode batch -source vivado_manage.tcl -notrace -tclargs setup
	@rm -f *.backup.jou *.backup.log

tbsim_source: vivado/vivado_project.xpr
	vivado -mode batch -source vivado_manage.tcl -notrace -tclargs simulate $(PROJ) $(TESTBENCH) $(TOP_LEVEL_FILE) $(COMPONENT_FILES)
	@rm -f *.backup.jou *.backup.log

tbsim_mapped: mapped/$(PROJ)_syn.v vivado/vivado_project.xpr
	vivado -mode batch -source vivado_manage.tcl -notrace -tclargs mapped $(DEVICE) $(PROJ) $(TESTBENCH) $< $(SIM_CELLS)
	@rm -f *.backup.jou *.backup.log

clean:
	@echo "Removing intermediate files"
	@rm -f intermediate/*.json intermediate/*.asc vivado.*
	@rm -f *.backup.jou *.backup.log
	@echo "Done"

veryclean: clean
	@echo  "Removing all generated files"
	@rm -rf mapped/*.v *_syntb.vcd vivado/* *.bin logs/*.log logs/*.rpt make_debug.txt
	@rm -rf .Xil/
	@echo  "Done"

print_vars:
	@echo "Component Files: \n $(foreach file, $(COMPONENT_FILES), $(file)\n)"
	@echo "Top level File: $(TOP_LEVEL_FILE)"
	@echo "Testbench: $(TESTBENCH)"
	@echo "Top level module: $(TOP_MODULE)"
	@echo "Cell modules File: $(SIM_LIBRARY)"
	@echo "Architecture: Lattice ICE40"
	@echo "Device: $(DEVICE)"
	@echo "Package: $(PACKAGE)"

.SECONDARY:
.PHONY: all debug help prog clean veryclean tbsim_source tbsim_mapped
