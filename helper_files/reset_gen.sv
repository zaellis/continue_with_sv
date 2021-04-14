module reset_gen(
    input clk,
    input in_rst,
    output n_rst
);

    `ifdef SIM
        assign n_rst = in_rst;
    `else
        reg internal_reset;

        initial begin
            internal_reset = 1'b0;
        end

        always_ff @(negedge clk) begin
            if(!internal_reset)
                internal_reset <= 1;
        end

        assign n_rst = internal_reset & in_rst;
    `endif

endmodule