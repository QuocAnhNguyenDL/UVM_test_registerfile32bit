`ifndef SEQUENCER
`define SEQUENCER

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "regfile_transaction.sv"
class regfile_sequencer extends uvm_sequencer#(regfile_transaction);
    `uvm_component_utils(regfile_sequencer);

    function new(string name = "regfile_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass


`endif