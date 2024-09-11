`ifndef TEST
`define TEST

`include "uvm_macros.svh"
`include "regfile_sequence.sv"
`include "regfile_env.sv"
import uvm_pkg::*;

class regfile_test extends uvm_test;
    `uvm_component_utils(regfile_test);

    regfile_env e0;
    regfile_sequence sq0;

    function new(string name = "regfile_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e0 = regfile_env::type_id::create("e0", this);
        sq0 = regfile_sequence::type_id::create("sq0");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
         sq0.start(e0.a0.s0);
        phase.drop_objection(this);
    endtask
    
endclass


`endif