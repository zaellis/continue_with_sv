module top(
    input clk,
    input in_rst, //only used for simulation
    output LED
);

    wire n_rst;

    reset_gen U1(        //power on reset module (reset input passthrough for simulation)         
        .clk(clk),
        .in_rst(in_rst),
        .n_rst(n_rst)    //reset output that gets used internally
    );

    reg [15:0] count, next_count; //counter value/next_value
    reg rollover, next_rollover;  //counter rollover flag
    reg [255:0] LED_schedule;     //LED on schedule
    reg dir, next_dir             //direction of LED brightness change



endmodule