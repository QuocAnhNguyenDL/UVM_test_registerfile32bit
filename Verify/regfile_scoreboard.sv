`ifndef SCOREBOARD
`define SCOREBOARD

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "regfile_transaction.sv"
class regfile_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(regfile_scoreboard);

    regfile_transaction act_tran, exp_tran;
    uvm_analysis_export#(regfile_transaction) rm2sb_export, mon2sb_export;
    uvm_tlm_analysis_fifo#(regfile_transaction) rm2sb_fifo, mon2sb_fifo;
    regfile_transaction act_trans_fifo, exp_trans_fifo;
    bit error = 0;

    function new(string name = "regfile_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rm2sb_export = new("rm2sb_export", this);
        mon2sb_export = new("mon2sb_export", this);
        act_trans_fifo = new("act_trans_fifo", this);
        exp_trans_fifo = new("exp_trans_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        rm2sb_export.connect(rm2sb_fifo.analysis_export);
        mon2sb_export.connect(mon2sb_export.analysis_export);
    endfunction
    
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            rm2sb_fifo.get(exp_tran);
            if(exp_tran == null) $stop;
            exp_trans_fifo.push_back(exp_tran);

            mon2sb_fifo.get(act_tran);
            if(act_tran == null) $stop;
            act_trans_fifo.push_back(act_tran);

            compare();
        end
    endtask

    task compare();
        regfile_transaction act_tran, exp_tran;

        if(act_trans_fifo.size != 0) begin
            act_tran = act_trans_fifo.pop_front();
            if(exp_trans_fifo.size != 0) begin
                exp_tran = exp_trans_fifo.pop_front();

                if(act.ReadData1 == exp.ReadData2 & act.ReadData2 == exp.ReadData2)
                begin
                    `uvm_info("SCOREBOARD", "CORRECT", UVM_LOW)
                end

                else 
                begin
                    `uvm_info("SCOREBOARD", "INCORRECT", UVM_LOW)
                    error = 1;
                end
            end
        end
    endtask

    function void report_phase(uvm_phase phase);
        if(error==0) begin
          $display("-------------------------------------------------");
          $display("---------- INFO : TEST CASE PASSED --------------");
          $display("-------------------------------------------------");
        end else begin
          $display("-------------------------------------------------");
          $display("---------- ERROR : TEST CASE FAILED -------------");
          $display("-------------------------------------------------");
        end
      endfunction 
    
    
    
endclass: regfile_scoreboard


`endif