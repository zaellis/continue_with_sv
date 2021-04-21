`timescale 1ns/1ps

module display_mux
(
    input wire clk,                     // Clock input
    input wire n_rst,                   // Asynch reset
    input wire [13:0] value,            // Value to display
    output reg [7:0] seg_val,           // Output for currently displayed value
    output reg [3:0] seg_sel            // Current 7 segment to display
);