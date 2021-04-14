#!/usr/bin/tclsh

if {$argc > 0} {
    set mode [lindex $argv 0]
    if {$mode == "setup"} {
        puts "Setting up Vivado Project"
        create_project vivado_project vivado/
        exit 0
    } elseif {$mode eq "simulate"} {
        set args [lreplace $argv 0 0]
        set project [lindex $args 0]
        set args [lreplace $args 0 0]
        set testbench [lindex $args 0]
        open_project vivado/vivado_project.xpr
        add_files -fileset [get_filesets sim_1] -quiet $args
        set_property TARGET_SIMULATOR XSim [current_project]
        set_property top tb_$project [get_filesets sim_1]
        set_property top_file $testbench [get_filesets sim_1]
        set_property verilog_define {SIM} [get_filesets sim_1]
        launch_simulation -simset sim_1
        restart
        start_gui
    } elseif {$mode eq "mapped"} {
        set args [lreplace $argv 0 0]
        set device [lindex $args 0]
        set args [lreplace $args 0 0]
        set project [lindex $args 0]
        set args [lreplace $args 0 0]
        set testbench [lindex $args 0]
        open_project vivado/vivado_project.xpr
        create_fileset -simset -quiet sim_2
        add_files -fileset [get_filesets sim_2] -quiet $args
        set_property TARGET_SIMULATOR XSim [current_project]
        set_property top tb_$project [get_filesets sim_2]
        set_property top_file $testbench [get_filesets sim_2]
        set_property verilog_define {SIM} [get_filesets sim_2]
        if {[string index $device 0] eq "l"} {
            set_property verilog_define {ICE40_LP} [get_filesets sim_2]
            reset_property verilog_define {ICE40_HX} [get_filesets sim_2] -quiet
            reset_property verilog_define {ICE40_U} [get_filesets sim_2] -quiet
        } elseif {[string index $device 0] eq "h"} {
            set_property verilog_define {ICE40_HX} [get_filesets sim_2]
            reset_property verilog_define {ICE40_LP} [get_filesets sim_2] -quiet
            reset_property verilog_define {ICE40_U} [get_filesets sim_2] -quiet
        } elseif {[string index $device 0] eq "u"} {
            set_property verilog_define {ICE40_U} [get_filesets sim_2]
            reset_property verilog_define {ICE40_LP} [get_filesets sim_2] -quiet
            reset_property verilog_define {ICE40_HX} [get_filesets sim_2] -quiet
        } else {
            puts "invalid device name"
            exit 1
        }
        launch_simulation -simset sim_2
        restart
        start_gui
    } else {
        puts "invalid mode"
        exit 1
    }
} else {
    puts "no args"
    exit 1
}