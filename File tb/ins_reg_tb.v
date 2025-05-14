`timescale 1ns / 1ps


module ins_reg_tb;

    reg clk;
    reg rst;
    reg ld_ir;
    reg [7:0] data_in;
    wire [2:0] opcode;
    wire [4:0] ir_addr;

    ins_reg uut (
        .clk(clk),
        .rst(rst),
        .ld_ir(ld_ir),
        .data_in(data_in),
        .opcode(opcode),
        .ir_addr(ir_addr)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        ld_ir = 0;
        data_in = 8'b01010100;

        // Test case 1: Reset
        #10;
        rst = 1;
        #10;
        rst = 0;

        // Test case 2: Load instruction
        #10;
        data_in = 8'b10111111; // opcode=101, addr=11111
        ld_ir = 1;
        #10;
        ld_ir = 0;

        // Test case 4: No load (should retain previous value)
        #10;
        data_in = 8'b00000000;
        #10;

        // Test case 5: Reset during load
        #10;
        data_in = 8'b11100011;
        ld_ir = 1;
        #5;
        rst = 1;
        #10;
        rst = 0;
        ld_ir = 0;

        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t rst=%b ld_ir=%b data_in=%b opcode=%b ir_addr=%b", 
                 $time, rst, ld_ir, data_in, opcode, ir_addr);
    end

endmodule