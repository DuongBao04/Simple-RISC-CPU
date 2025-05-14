`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2025 12:11:22 PM
// Design Name: 
// Module Name: memory_tb
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


module memory_tb;
    reg clk;
    reg [4:0] addr;
    reg rd;
    reg wr;
    wire [7:0] data;
    
    // Local variable
    reg [7:0] data_bus; 

    assign data = (wr && !rd) ? data_bus : 8'bz;

    memory uut (
        .clk(clk),
        .addr(addr),
        .rd(rd),
        .wr(wr),
        .data(data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        addr = 5'b00000;
        rd = 0;
        wr = 0;
        data_bus = 8'b00000000;

        // Test case 1: Write to address 0
        #10;
        addr = 5'b00000;
        data_bus = 8'b10101010;
        wr = 1;
        #10;
        wr = 0;
        $display("Test 1: Write %b to addr %b, mem[%b]=%b", data_bus, addr, addr, uut.mem[addr]);

        // Test case 2: Read from address 0
        #10;
        rd = 1;
        #10;
        $display("Test 2: Read from addr %b: data=%b, mem[%b]=%b (Expected: 10101010)", addr, data, addr, uut.mem[addr]);
        rd = 0;

        // Test case 3: Write to address 15
        #10;
        addr = 5'b01111;
        data_bus = 8'b11110000;
        wr = 1;
        #10;
        wr = 0;
        $display("Test 3: Write %b to addr %b, mem[%b]=%b", data_bus, addr, addr, uut.mem[addr]);

        // Test case 4: Read from address 15
        #10;
        rd = 1;
        #10;
        $display("Test 4: Read from addr %b: data=%b, mem[%b]=%b (Expected: 11110000)", addr, data, addr, uut.mem[addr]);
        rd = 0;

        // End simulation
        #10;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t addr=%b rd=%b wr=%b data=%b mem[%b]=%b", 
                 $time, addr, rd, wr, data, addr, uut.mem[addr]);
    end

endmodule
