`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2025
// Design Name: 
// Module Name: controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for controller module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module controller_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [2:0] opcode;
    reg is_zero;

    // Outputs
    wire sel;
    wire rd;
    wire ld_ir;
    wire halt;
    wire inc_pc;
    wire ld_ac;
    wire wr;
    wire ld_pc;
    wire data_e;

    // Instantiate the Unit Under Test (UUT)
    controller uut (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .is_zero(is_zero),
        .sel(sel),
        .rd(rd),
        .ld_ir(ld_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .ld_ac(ld_ac),
        .wr(wr),
        .ld_pc(ld_pc),
        .data_e(data_e)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        opcode = 3'b000;
        is_zero = 0;

        // Reset the system
        #10;
        reset = 0;

        // Test case 1: HLT (opcode = 000)
        opcode = 3'b000; // HLT
        #80; // Wait for 8 clock cycles to observe all states

        // Test case 2: ADD (opcode = 010)
        reset = 1;
        #10;
        reset = 0;
        opcode = 3'b010; // ADD
        #80;

        // Test case 3: SKZ with is_zero = 1 (opcode = 001)
        reset = 1;
        #10;
        reset = 0;
        opcode = 3'b001; // SKZ
        is_zero = 1;
        #80;

        // Test case 4: SKZ with is_zero = 0 (opcode = 001)
        reset = 1;
        #10;
        reset = 0;
        opcode = 3'b001; // SKZ
        is_zero = 0;
        #80;

        // Test case 5: STO (opcode = 110)
        reset = 1;
        #10;
        reset = 0;
        opcode = 3'b110; // STO
        #80;

        // Test case 6: JMP (opcode = 111)
        reset = 1;
        #10;
        reset = 0;
        opcode = 3'b111; // JMP
        #80;

        // Test case 7: LDA (opcode = 101)
        reset = 1;
        #10;
        reset = 0;
        opcode = 3'b101; // LDA
        #80;

        // End simulation
        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | State=%0d | opcode=%b | is_zero=%b | sel=%b | rd=%b | ld_ir=%b | halt=%b | inc_pc=%b | ld_ac=%b | wr=%b | ld_pc=%b | data_e=%b",
                 $time, uut.state, opcode, is_zero, sel, rd, ld_ir, halt, inc_pc, ld_ac, wr, ld_pc, data_e);
    end

endmodule