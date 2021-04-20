`timescale 1ns/1ps

module top
(
   input wire clk,                     // Clock for the design
   input wire n_rst,                   // Reset button (used for counting here)
   output reg [7:0] led,               // User controllable LEDs
   input wire usb_rx,                  // FTDI RX pin
   output wire usb_tx                  // FTDI TX pin
);

   assign usb_tx = usb_rx;             // Mirror input to output

   always @ (posedge n_rst) begin
      led <= led + 1;
   end

endmodule