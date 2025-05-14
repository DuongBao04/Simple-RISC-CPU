`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 11:39:31 AM
// Design Name: 
// Module Name: acc_reg_tb
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


module acc_reg_tb;
    reg clk;
    reg rst;
    reg ld_ac;
    reg [7:0] data_in;
    wire [7:0] data_out;

    acc_reg uut (
        .clk(clk),
        .rst(rst),
        .ld_ac(ld_ac),
        .data_in(data_in[7:0]),
        .data_out(data_out[7:0])
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;
        ld_ac = 0;
        data_in = 8'b00010100;

        #10;
        rst = 1;
        #10;
        rst = 0;

        // Test case 2: Load data
        #10;
        data_in = 8'b10101011;
        ld_ac = 1;
        #10;
        ld_ac = 0;

        //
        // Test case 5: Reset during load
        #10;
        data_in = 8'b11001100;
        ld_ac = 1;
        #5;
        rst = 1;
        #10;
        rst = 0;
        ld_ac = 0;
        
        #20
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t rst=%b ld_ac=%b data_in=%b data_out=%b", 
                 $time, rst, ld_ac, data_in, data_out);
    end

endmodule
