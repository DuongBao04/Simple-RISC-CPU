`timescale 1ns / 1ps

module memory (
    input clk,               // Clock signal
    input [4:0] addr,        // 5-bit address
    input rd,                // Read enable
    input wr,                // Write enable
    inout [7:0] data         // 8-bit bidirectional data port
);
    // Array to store data
    reg [7:0] mem [0:31];    // 32 locations of 8-bit each
    
    // For output direction (when reading)
    // 'z' represents high impedance (tri-state)
    assign data = (rd && !wr) ? mem[addr] : 8'bz;
    
    // For input direction (when writing)
    always @(posedge clk) begin
        if (wr && !rd)
            mem[addr] <= data;
    end
endmodule