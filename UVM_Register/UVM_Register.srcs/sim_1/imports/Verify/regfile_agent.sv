`ifndef AGENT
`define AGENT

`include "uvm_macros.svh"
`include "regfile_driver.sv"
`include "regfile_sequencer.sv"
`include "regfile_monitor.sv"
import uvm_pkg::*;

class regfile_agent extends uvm_agent;
    `uvm_component_utils(regfile_agent);

    regfile_sequencer s0;
    regfile_driver d0;
    regfile_monitor m0;

    function new(string name = "regfile_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        s0 = regfile_sequencer::type_id::create("s0", this);
        d0 = regfile_driver::type_id::create("d0", this);
        m0 = regfile_monitor::type_id::create("m0", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d0.seq_item_port.connect(s0.seq_item_export);
    endfunction
endclass


`endif 