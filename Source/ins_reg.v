`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:54:00 PM
// Design Name: 
// Module Name: ins_reg
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


module ins_reg(
    input clk,
    input rst,
    input ld_ir,
    input [7:0] data_in,
    output [2:0] opcode,
    output [4:0] ir_addr
);
    reg [7:0] ir;
    always @(posedge clk or posedge rst) begin
        if (rst)
            ir <= 8'b0;
        else if (ld_ir)
            ir <= data_in;
    end
    assign opcode = ir[7:5];  // 3 bit cao là opcode
    assign ir_addr = ir[4:0]; // 5 bit thấp là địa chỉ
endmodule
