`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 11:28:35 AM
// Design Name: 
// Module Name: address_mux_tb
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


module address_mux_tb;
    parameter ADDR_WIDTH = 5;

    reg [ADDR_WIDTH-1:0] pc_addr;
    reg [ADDR_WIDTH-1:0] ir_addr;
    reg sel;
    wire [ADDR_WIDTH-1:0] mem_addr;

    address_mux #(.ADDR_WIDTH(ADDR_WIDTH)) uut (
        .pc_addr(pc_addr),
        .ir_addr(ir_addr),
        .sel(sel),
        .mem_addr(mem_addr)
    );

    initial begin
        pc_addr = 5'b00000;
        ir_addr = 5'b00000;
        sel = 0;

        // Test case 1: Select IR address (sel = 0)
        #10;
        pc_addr = 5'b10101;
        ir_addr = 5'b01010;
        sel = 0;
        #10;

        // Test case 2: Select PC address (sel = 1)
        #10;
        sel = 1;
        #10;

        #10;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t sel=%b pc_addr=%b ir_addr=%b mem_addr=%b", 
                 $time, sel, pc_addr, ir_addr, mem_addr);
    end

endmodule
