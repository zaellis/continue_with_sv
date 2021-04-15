module tb_top();

    parameter CLK_PERIOD = 62.5; //16 MHz

    reg tb_clk, tb_in_rst;
    wire tb_LED;

    top DUT(
        .clk(tb_clk),
        .in_rst(tb_in_rst),
        .LED(tb_LED)
    );

    task reset_dut;
    begin
        // Activate the design's reset (does not need to be synchronize with clock)
        tb_in_rst = 1'b0;
        
        // Wait for a couple clock cycles
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        // Release the reset
        @(negedge tb_clk);
        tb_in_rst = 1'b1;
        
        // Wait for a while before activating the design
        @(posedge tb_clk);
        @(posedge tb_clk);
    end
    endtask

    always
    begin : CLK_GEN
        tb_clk = 1'b0;
        #(CLK_PERIOD / 2);
        tb_clk = 1'b1;
        #(CLK_PERIOD / 2);
    end

    initial
    begin
        tb_in_rst = 1'b1;

        reset_dut();
    end


endmodule