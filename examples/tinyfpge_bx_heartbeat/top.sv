module top(
    input clk,
    input in_rst, //only used for simulation
    output LED
);

    localparam period = 244 - 1; //sets period of heartbeat [0-255], and technically also maximum brightness
                                 //243 (244 -1) is about 1 second each direction(2 second period in total)

    wire n_rst;

    reset_gen U1(        //power on reset module (reset input passthrough for simulation)         
        .clk(clk),
        .in_rst(in_rst),
        .n_rst(n_rst)    //reset output that gets used internally
    );

    reg [15:0] count;                //counter value
    reg [7:0] compare, next_compare; //compare value for "PWM"
    reg dir, next_dir;               //compare increment direction

    always_ff @(posedge clk, negedge n_rst) begin //registering
        if(n_rst == 0) begin
            count <= '0;
            compare <= '0;
            dir <= 1'b0;
        end
        else begin
            count <= count + 1;
            compare <= next_compare;
            dir <= next_dir;
        end
    end

    always_comb begin           //compare and direction setting logic
        next_compare = compare;
        next_dir = dir;
        if(count == '1) begin
            if(dir)
                next_compare = compare + 1;
            else
                next_compare = compare - 1;
        end
        if((count == 16'd0) && ((compare == period) || (compare == 8'd0)))
            next_dir = dir ^ 1'b1;

    end

    assign LED = (compare > count[7:0]) ? 1'b1 : 1'b0;


endmodule