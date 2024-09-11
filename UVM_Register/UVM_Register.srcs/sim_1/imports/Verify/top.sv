`include "uvm_macros.svh"
`include "regfile_interface.sv"
import uvm_pkg::*;

module top;
    bit clk, reset;
    
    initial begin
        #0 reset = 1;
        #20 reset = 0;
    end

    initial begin
        #0 clk = 0;
        forever #5 clk = ~clk;
    end

    regfile_interface r_if(clk, reset);

    Registers DUT(
        .clk(r_if.clk),
        .reset(r_if.reset),
        .ReadAddr1(r_if.ReadAddr1),
        .ReadAddr2(r_if.ReadAddr2),
        .WriteData(r_if.WriteData),
        .WriteAddr(r_if.WriteAddr),
        .ReadData1(r_if.ReadData1),
        .ReadData2(r_if.ReadData2)
    );

    initial begin
        run_test("regfile_test");
    end

    initial begin
        uvm_config_db#(virtual regfile_interface)::set(uvm_root::get(),"*", "r_if", r_if);
    end    
    
endmodule
