`timescale 1ns/1ps

module pulldown
#(
    parameter BIT_WIDTH = 8                                         // Number of bits for the pulldown
)
(
    input wire clk,                                                 // Clock input
    input wire n_rst,                                               // Asynch reset
    inout wire [BIT_WIDTH - 1:0] io                                 // IO pin to be pulled down
    output reg [BIT_WIDTH - 1:0] out;                               // Output read from IO pins              
);

    reg state;                                                      // Var to be toggled
    reg [BIT_WIDTH - 1:0] out_next;                                 // Next value to assign to the output

    assign io = state ? {{BIT_WIDTH}1'bz} : {{BIT_WIDTH}1'b0};      // Assign to high impedance one clock cycle, then low the next
    assign out_next = state ? io : out;                             // Assign to IO pins when high impedance, last output if not

    always_ff @ (posedge clk, negedge n_rst) begin                  // Trigger on rising edge of clock, falling edge of reset
        if (n_rst == 1'b0) begin                                    // Check if reset is active (active low)
            state <= 0;                                             // Reset state
            out <= {{BIT_WIDTH}1'b0};                               // Set output to 0
        end else begin                                              // No reset active
            out <= out_next;                                        // Update output
            state <= !state;                                        // Toggle state
        end
    end

endmodule