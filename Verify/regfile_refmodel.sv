`ifndef REGFILEREFMODEL
`define REGFILEREFMODEL

`include "uvm_macros.svh"
import uvm_pkg::*;

class regfile_refmodel extends uvm_component;
    `uvm_component_utils(regfile_refmodel);

    uvm_analysis_export#(regfile_transaction) dr2rm_export;
    uvm_analysis_port#(regfile_transasction) rm2sb_port;
    uvm_tlm_analysis_fifo#(regfile_transasction) rm_exp_fifo;
    regfile_model regfile;
    regfile_transaction rm_tran, exp_tran;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        dr2rm_export = new("dr2rm_export", this);
        rm2sb_port = new("rm2sb_port", this);
        rm_exp_fifo = new("rm_exp_fifo", this);
        regfile.build();
    endfunction

    function void regfile_refmodel::connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        dr2rm_export.connect(rm_exp_fifo.analysis_export);
    endfunction: connect_phase
    
    task regfile_refmodel::run_phase(uvm_phase phase);
        forever begin
            rm_exp_fifo.get(rm_tran);
            get_expected_transaction();
        end
    endtask: run_phase
    
    task get_expected_transaction();
        uvm_reg_data_t value;
        uvm_status_e status;

        exp_tran = rm_tran;
        regfile.reg[exp_tran.ReadAddr1].read(status, value, .parent(this));
        regfile.reg[exp_tran.ReadAddr2].read(status, value, .parent(this));

        exp_tran.ReadData1 = value1;
        exp_tran.ReadData2 = value2;
        rm2sb_port.write(exp_tran);
    endtask: name
    

    function new(string name = "regfile_refmodel");
        super.new(name);
    endfunction: new
    
endclass: regfile_refmodel


`endif
