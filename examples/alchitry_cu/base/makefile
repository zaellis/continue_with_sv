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

TOP_LEVEL_FILE := cu_top.sv
COMPONENT_FILES := 

# Note: For work using an Alchitry CU, do not change package, nor device.
#       Changing the package will clash with the pcf file. Changing device
#       would be plain dumb. I only leave these here in case the makefile is
#       used elsewhere (but seriously, there are much better makefiles than this)

PIN_DEF := ../../../pcf/alchitry_cu.pcf
PACKAGE := cb132
DEVICE := 8k

all:
	@echo "Starting Yosys. View output in reports/synth.txt"
	yosys -q -p "synth_ice40 -blif cu.blif" $(TOP_LEVEL_FILE) $(COMPONENT_FILES) 2>&1 | tee reports/synth.txt
	@echo "\nStarting placement. View output in reports/place.txt"
	arachne-pnr -P $(PACKAGE) -p $(PIN_DEF) -d $(DEVICE) cu.blif -o cu.txt 2>&1 | tee reports/place.txt
	@echo "\nStarting explain. View output in reports/explain.ex"
	icebox_explain cu.txt > reports/explain.ex
	@echo "\nStarting packing"
	icepack cu.txt cu.bin

clean:
	rm -f *.blif *.txt *.ex *.bin
	rm -f reports/*
