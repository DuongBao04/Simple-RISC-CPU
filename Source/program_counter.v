`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2025 09:22:52 PM
// Design Name: 
// Module Name: program_counter
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

module program_counter (
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal (active high)
    input wire ld_pc,         // Load signal
    input wire inc_pc,        // Increment signal
    input wire halt,          // Thêm tín hiệu halt
    input wire [4:0] load_addr, // Address to be loaded (5-bit)
    output reg [4:0] pc_addr    // Current counter value (5-bit)
);

    // Counter logic
    always @(posedge clk) begin
        if (rst) begin
            // Reset counter to 0 when reset is active
            pc_addr <= 5'b00000;
        end else if (!halt) begin // Chỉ cập nhật nếu halt = 0
            if (ld_pc) begin
                // Load external value when load signal is active
                pc_addr <= load_addr;
            end else if (inc_pc) begin
                // Increment counter during inc_pc operation
                pc_addr <= pc_addr + 1'b1;
            end
        end
    end
endmodule