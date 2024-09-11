`ifndef AGENT
`define AGENT

`include "uvm_macros.svh"
`include "driver.sv"
`include "sequencer.sv"
`include "monitor.sv"
import uvm_pkg::*;

class regfile_agent extends uvm_agent;
    `uvm_component_utils(regfile_agent);

    regfile_sequencer s0;
    regfile_driver d0;
    regfile_monitor m0;

    function new(string name = "regfile_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void regfile_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);
        s0 = regfile_sequencer::type_id::create("s0", this);
        d0 = regfile_driver::type_id::create("do", this);
        m0 = regfile_monitor::type_id::create("mo", this);
    endfunction: build_phase

    function void regfile_agent::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
    endfunction: connect_phase
    
endclass


`endif 