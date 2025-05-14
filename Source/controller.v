`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 08:34:14 PM
// Design Name: 
// Module Name: Controller
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


module controller (
    input clk, rst,
    input [2:0] opcode,
    input is_zero, 
    output reg sel, rd, ld_ir, halt, inc_pc, ld_ac, wr, ld_pc, data_e
);
    parameter INST_ADDR = 3'd0,
              INST_FETCH = 3'd1,
              INST_LOAD = 3'd2,
              IDLE = 3'd3,
              OP_ADDR = 3'd4,
              OP_FETCH = 3'd5,
              ALU_OP = 3'd6,
              STORE = 3'd7,
              HALT = 3'd8; // Thêm trạng thái HALT
    
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if (rst) state <= INST_ADDR;
        else state <= next_state;
    end
    
    always @(*) begin
        case (state)
            INST_ADDR: next_state = INST_FETCH;
            INST_FETCH: next_state = INST_LOAD;
            INST_LOAD: next_state = IDLE;
            IDLE: next_state = OP_ADDR;
            OP_ADDR: next_state = (opcode == 3'b000) ? HALT : OP_FETCH; // Chuyển sang HALT nếu opcode là HLT
            OP_FETCH: next_state = ALU_OP;
            ALU_OP: next_state = STORE;
            STORE: next_state = INST_ADDR;
            HALT: next_state = HALT; // Giữ trạng thái HALT cho đến khi reset
            default: next_state = INST_ADDR;
        endcase
    end
    
    always @(*) begin
        sel = 0; rd = 0; ld_ir = 0; halt = 0; inc_pc = 0;
        ld_ac = 0; ld_pc = 0; data_e = 0; wr = 0;
        
        case (state)
            INST_ADDR: begin
                sel = 1;
            end
            INST_FETCH: begin
                sel = 1;
                rd = 1;
            end
            INST_LOAD: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end
            IDLE: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
            end
            OP_ADDR: begin
                inc_pc = 1;
                if (opcode == 3'b000) halt = 1; 
            end
            OP_FETCH: begin
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) rd = 1;
            end
            ALU_OP: begin
                sel = 0;
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101)
                    rd = 1; // ALUOP
                if (opcode == 3'b001 && is_zero)
                    inc_pc = 1; // SKZ & zero
                if (opcode == 3'b111)
                    ld_pc = 1; // JMP
                if (opcode == 3'b110)
                    data_e = 1; // STO
            end
            STORE: begin
                if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) begin
                    rd = 1;    // ALUOP
                    ld_ac = 1; 
                end
                if (opcode == 3'b111)
                    ld_pc = 1; // JMP
                if (opcode == 3'b110) begin
                    wr = 1;
                    data_e = 1; // STO
                end
            end
            HALT: begin
                halt = 1; // Giữ tín hiệu halt = 1
                // Tất cả các tín hiệu khác mặc định là 0
            end
        endcase
    end
endmodule