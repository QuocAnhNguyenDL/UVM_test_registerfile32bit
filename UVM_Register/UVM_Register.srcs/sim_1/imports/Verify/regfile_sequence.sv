`ifndef SEQUENCE 
`define SEQUENCE

`include "uvm_macros.svh"
`include "regfile_transaction.sv"
import uvm_pkg::*;

class regfile_sequence extends uvm_sequence#(regfile_transaction);
    `uvm_object_utils(regfile_sequence);

    function new(string name = "regfile_sequence");
        super.new(name);
    endfunction

    virtual task body();
        for(int i = 0 ; i < 100 ; i = i + 1)
        begin
            regfile_transaction req;
            req = regfile_transaction::type_id::create("req");
            start_item(req);
            assert(req.randomize())
            finish_item(req);
            get_response(rsp);
        end
    endtask
endclass: regfile_sequence

`endif