`timescale 1ns/1ps

module top
(
   input wire clk,                     // Clock for the design
   input wire n_rst,                   // Reset button (used for counting here)
   input wire [4:0] io_button,         // Element buttons
   output reg [7:0] led,               // User controllable LEDs
   output reg [23:0] io_led,           // Element board LEDs
   input wire [23:0] io_dip,           // DIP switches
   output reg [3:0] io_sel,            // Idk honestly
   output wire [7:0] io_seg,           // 7 segment
   input wire usb_rx,                  // FTDI RX pin
   output wire usb_tx                  // FTDI TX pin
);

   assign usb_tx = usb_rx;             // Mirror input to output
   assign io_seg = 8'h00;              // Turn on 7 segments

   reg [7:0] led_next;                 // Next value for the LEDs
   reg [23:0] io_led_next;             // Next value for IO LEDs
   reg [3:0] io_sel_next;              // Next 7 segment display           

   always_comb begin : update
      led_next = led + 1;
      io_led_next = io_led + 1;
      io_sel_next = io_sel << 1;
   end

   always_ff @ (posedge io_button[3], negedge n_rst) begin
      if (n_rst == 1'b0) begin
         led <= 8'b0;
         io_led <= 24'd0;
         io_sel <= 8'd1;
      end else begin
         led <= led_next;
         io_led <= io_led_next;
         io_sel <= led_next;
      end
   end

endmodule