`ifndef REGFILEREFMODEL
`define REGFILEREFMODEL

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "regfile_transaction.sv"
`include "regfile_model.sv"

class regfile_refmodel extends uvm_component;
    `uvm_component_utils(regfile_refmodel);

    uvm_analysis_export#(regfile_transaction) dr2rm_export;
    uvm_analysis_port#(regfile_transaction) rm2sb_port;
    uvm_tlm_analysis_fifo#(regfile_transaction) rm_exp_fifo;
    regfile_model regfile;
    regfile_transaction rm_tran, exp_tran;
    
    function new(string name = "regfile_refmodel", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        dr2rm_export = new("dr2rm_export", this);
        rm2sb_port = new("rm2sb_port", this);
        rm_exp_fifo = new("rm_exp_fifo", this);
        regfile = regfile_model::type_id::create("regfile", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dr2rm_export.connect(rm_exp_fifo.analysis_export);
    endfunction
    
    task run_phase(uvm_phase phase);
        forever begin
            rm_exp_fifo.get(rm_tran);
            get_expected_transaction();
        end
    endtask
    
    task get_expected_transaction();
        exp_tran = rm_tran;
        
        exp_tran.ReadData1 = regfile.regs[exp_tran.ReadAddr1];
        exp_tran.ReadData2 = regfile.regs[exp_tran.ReadAddr2];
        rm2sb_port.write(exp_tran);
    endtask
    
endclass

`endif
