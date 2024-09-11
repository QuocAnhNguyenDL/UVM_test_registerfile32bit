`ifndef REGFILEMODEL
`define REGFILEMODEL

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "reg32bit.sv"

//class regfile_model extends uvm_reg_block;
//    `uvm_object_utils(regfile_model)

//    reg32bit regs[32];
//    reg32bit r;

//    function new(string name = "regfile_refmodel");
//        super.new(name, UVM_NO_COVERAGE);
//    endfunction

//    virtual function void build();
//        this.default_map = create_map("",0,4, UVM_LITTLE_ENDIAN,0);
//        for(int i = 0 ; i < 31 ; i = i + 1) begin
//            regs[i] = reg32bit::type_id::create($sformatf("reg[%0d]",i));
//            regs[i].build(0);
//            regs[i].configure(this);
//            default_map.add_reg(regs[i], 32'h0 + (i*4), "RW");
//        end
//        lock_model();
//    endfunction
//endclass

class regfile_model extends uvm_component;
    `uvm_component_utils(regfile_model)
    
     int regs[32];
     
     function new(string name, uvm_component parent);
        super.new(name, parent);
     endfunction
     
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        for(int i = 0 ; i < 31 ; i++) begin
            regs[i] = i;
        end
    endtask
endclass

`endif







