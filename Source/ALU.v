`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2025 09:27:11 PM
// Design Name: 
// Module Name: ALU
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


module ALU (
    input [2:0] opcode,
    input [7:0] inA,      // Từ Accumulator
    input [7:0] inB,      // Từ Memory
    output reg [7:0] out,
    output is_zero
);
    parameter HLT = 3'b000;
    parameter SKZ = 3'b001;
    parameter ADD = 3'b010;
    parameter AND = 3'b011;
    parameter XOR = 3'b100;
    parameter LDA = 3'b101;
    parameter STO = 3'b110;
    parameter JMP = 3'b111;

    always @(*) begin
        case (opcode)
            HLT: out = inA;
            SKZ: out = inA;
            ADD: out = inA + inB;
            AND: out = inA & inB;
            XOR: out = inA ^ inB;
            LDA: out = inB;
            STO: out = inA;
            JMP: out = inA;
            default: out = inA;
        endcase
    end
    assign is_zero = (inA == 8'b0);
endmodule

