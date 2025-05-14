`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 11:13:37 AM
// Design Name: 
// Module Name: program_counter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter_tb;

    reg clk;
    reg rst;
    reg ld_pc;
    reg inc_pc;
    reg [4:0] load_addr;
    wire [4:0] pc_addr;

    program_counter uut (
        .clk(clk),
        .rst(rst),
        .ld_pc(ld_pc),
        .inc_pc(inc_pc),
        .load_addr(load_addr[4:0]),
        .pc_addr(pc_addr[4:0])
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        rst = 0;
        ld_pc = 0;
        inc_pc = 0;
        load_addr = 5'b00000;

        // Reset the counter
        #10;
        rst = 1;
        #10;
        rst = 0;

        // Test increment operation
        #10;
        inc_pc = 1;
        #10;
        inc_pc = 0;

        // Test load operation
        #10;
        load_addr = 5'b10101;
        ld_pc = 1;
        #10;
        ld_pc = 0;

        // Test multiple increments
        #10;
        inc_pc = 1;
        #30; // 3 clock cycles
        inc_pc = 0;
        $display("After 3 increments: pc_addr = %b", pc_addr);

        // Test load with different value
        #10;
        load_addr = 5'b11111;
        ld_pc = 1;
        #10;
        ld_pc = 0;
        $display("After load (11111): pc_addr = %b", pc_addr);

        // Test reset during operation
        #10;
        inc_pc = 1;
        #5;
        rst = 1;
        #10;
        rst = 0;
        inc_pc = 0;

        // End simulation
        #20;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t rst=%b ld_pc=%b inc_pc=%b load_addr=%b pc_addr=%b", 
                 $time, rst, ld_pc, inc_pc, load_addr, pc_addr);
    end

endmodule
