`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 04:57:48 PM
// Design Name: 
// Module Name: acc_reg
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


module acc_reg(
    input clk,
    input rst,
    input ld_ac,
    input [7:0] data_in,
    output reg [7:0] data_out
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 8'b0;
        else if (ld_ac)
            data_out <= data_in;
    end
endmodule
