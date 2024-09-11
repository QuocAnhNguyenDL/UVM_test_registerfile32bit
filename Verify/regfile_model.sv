`ifndef REGFILEMODEL
`define REGFILEMODEL

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "reg32bit.sv"


class regfile_refmodel extends uvm_reg_block;
    `uvm_component_utils(regfile_refmodel);

    reg32bit regs[32];

    function new(string name = "regfile_refmodel");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    function void build(uvm_phase phase);
        for(int i = 0 ; i < 31 ; i = i + 1) begin
            regs[i] = reg32bit::type_id::create("reg[%d]",i);
            regs[i].build(i);
            regs[i].configure(this);
            this.default_map.add_reg(regs[i], 32'h0 + (i*4), "RW");
        end
endfunction
    
endclass

`endif