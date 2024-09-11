`ifndef INTERFACE
`define INTERFACE

interface regfile_interface(input logic clk, reset);
    logic [4:0] ReadAddr1, ReadAddr2, WriteAddr;
    logic [31:0] WriteData;
    logic RegWrite;
    logic [31:0] ReadData1, ReadData2;
    
    clocking dr_cb@(posedge clk);
        output ReadAddr1;
        output ReadAddr2;
        output WriteAddr;
        output WriteData;
        output RegWrite;
        input ReadData1;
        input ReadData2;
    endclocking

    modport DRV(clocking dr_cb, input clk, reset);

    clocking rc_cb@(negedge clk);
        input ReadAddr1;
        input ReadAddr2;
        input WriteAddr;
        input WriteData;
        input RegWrite;
        input ReadData1;
        input ReadData2;
    endclocking

    modport RCV(clocking rc_cb, input clk, reset);
    
endinterface
`endif
