`timescale 1ns/1ps

module top
(
   input wire clk,                     // Clock for the design
   input wire n_rst,                   // Reset button (used for counting here)
   inout wire [4:0] io_button,         // Element buttons
   output reg [7:0] led,               // User controllable LEDs
   output reg [23:0] io_led,           // Element board LEDs
   input wire [23:0] io_dip,           // DIP switches
   output reg [3:0] io_sel,            // Selection for which 7 segment we're displaying on
   output wire [7:0] io_seg,           // 7 segment
   input wire usb_rx,                  // FTDI RX pin
   output wire usb_tx                  // FTDI TX pin
);
   // Locals
   reg [4:0] button_pd;                // Output of buttons when pulled down
   reg [23:0] dip_pd;                  // Output of DIP switches when pulled down

   // Module Instantiation
   pulldown bpd #(5) (.clk(clk), .n_rst(n_rst), .io(io_button), .out(button_pd));
   pulldown dippd #(24) (.clk(clk), .n_rst(n_rst), .io(io_dip), .out(dip_pd));

   assign usb_tx = usb_rx;             // Mirror input to output

endmodule