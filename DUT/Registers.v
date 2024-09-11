`timescale 1ns / 1ps

module Registers(
    input clk,
    input reset,
    input [4:0] ReadAddr1, ReadAddr2,
    input [4:0] WriteAddr,
    input [31:0] WriteData,
    input RegWrite,
    output [31:0] ReadData1, ReadData2
    );
    
    reg [31:0] RF [0:31];
    
    assign ReadData1 = RF[ReadAddr1];
    assign ReadData2 = RF[ReadAddr2];
    
    always @(posedge clk)
    begin
        if(RegWrite == 1) RF[WriteAddr] <= WriteData;
    end
    
    always @(posedge reset)
    begin
        RF[0] = 0;
    end
endmodule
