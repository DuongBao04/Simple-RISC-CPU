`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2025 02:10:43 PM
// Design Name: 
// Module Name: cpu
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
module cpu(
    input wire clk,
    input wire rst
);

wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e; // Tín hiệu từ Controller
wire [4:0] pc_addr;           // Địa chỉ từ Program Counter
wire [4:0] ir_addr;           // Địa chỉ từ Instruction Register
wire [4:0] mem_addr;          // Lựa chọn giữa PC và IR
wire [2:0] opcode;
wire is_zero;                

wire [7:0] data_bus;          // Trung gian làm bidirectional port
wire [7:0] acc_out;           // Giá trị từ Accumulator
wire [7:0] alu_out;           // Kết quả từ ALU

program_counter PC(
    .clk(clk),
    .rst(rst),
    .inc_pc(inc_pc),
    .ld_pc(ld_pc),
    .halt(halt), // Thêm tín hiệu halt
    .load_addr(ir_addr[4:0]),
    .pc_addr(pc_addr[4:0])
);

ins_reg ir(
    .clk(clk),
    .rst(rst),
    .ld_ir(ld_ir),
    .data_in(data_bus[7:0]),
    .opcode(opcode[2:0]),
    .ir_addr(ir_addr[4:0])
);

acc_reg accumulator(
    .clk(clk),
    .rst(rst),
    .ld_ac(ld_ac),
    .data_in(alu_out[7:0]),
    .data_out(acc_out[7:0])
);

ALU alu (
    .opcode(opcode[2:0]),
    .inA(acc_out[7:0]),
    .inB(data_bus[7:0]),
    .out(alu_out[7:0]),
    .is_zero(is_zero)
);

address_mux #(
    .ADDR_WIDTH(5)
) addr_mux(
    .pc_addr(pc_addr[4:0]),
    .ir_addr(ir_addr[4:0]),
    .sel(sel),
    .mem_addr(mem_addr[4:0])
);

memory mem(
    .clk(clk),               
    .addr(mem_addr[4:0]),       
    .rd(rd),               
    .wr(wr),               
    .data(data_bus[7:0])         
);

controller ctrl (
    .clk(clk),
    .rst(rst),
    .opcode(opcode[2:0]),
    .is_zero(is_zero),
    .sel(sel),
    .rd(rd),
    .ld_ir(ld_ir),
    .halt(halt),
    .inc_pc(inc_pc),
    .ld_ac(ld_ac),
    .ld_pc(ld_pc),
    .wr(wr),
    .data_e(data_e)
);

assign data_bus = (data_e && wr) ? acc_out : 8'bz;

endmodule
