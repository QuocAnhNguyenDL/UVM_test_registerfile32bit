`ifndef ENV
`define ENV

`include "uvm_macros.svh"
`include "regfile_agent.sv"
`include "regfile_scoreboard.sv"
`include "regfile_refmodel.sv"
import uvm_pkg::*;

class regfile_env extends uvm_env;
    `uvm_component_utils(regfile_env);
    
    regfile_agent a0;
    regfile_scoreboard sb0;
    regfile_refmodel rm0;

    function new(string name = "regfile_env", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        a0 = regfile_agent::type_id::create("a0", this);
        sb0 = regfile_scoreboard::type_id::create("sb0", this);
        rm0 = regfile_refmodel::type_id::create("rm0", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a0.d0.dr2rm_port.connect(rm0.dr2rm_export);
        a0.m0.mon2sb_port.connect(sb0.mon2sb_export);
        rm0.rm2sb_port.connect(sb0.rm2sb_export);
    endfunction
    
    
endclass


`endif