`ifndef MONITOR
`define MONITOR

`include "uvm_macros.svh"
`include "regfile_transaction.sv"
`include "regfile_interface.sv"
import uvm_pkg::*;

class regfile_monitor extends uvm_monitor;
    `uvm_component_utils(regfile_monitor);

    virtual regfile_interface r_if;
    uvm_analysis_port#(regfile_transaction) mon2sb_port;
    regfile_transaction act_tran;

    function new(string name = "regfile_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual regfile_interface)::get(this,"","r_if",r_if))
            `uvm_fatal("MON","COULD NOT GET VIF");
        mon2sb_port = new("mon2sb", this);
        act_tran = new("act_tran");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            collect_tran();
            mon2sb_port.write(act_tran);
        end
    endtask

    task collect_tran();
        wait(!r_if.reset);
        @(r_if.rc_cb);
            act_tran.ReadAddr1 <= r_if.rc_cb.ReadAddr1;
            act_tran.ReadAddr2 <= r_if.rc_cb.ReadAddr2;
            act_tran.WriteData <= r_if.rc_cb.WriteData;
            act_tran.WriteAddr <= r_if.rc_cb.WriteAddr;
            act_tran.RegWrite <= r_if.rc_cb.RegWrite;
            act_tran.ReadData1 <= r_if.rc_cb.ReadData1;
            act_tran.ReadData2 <= r_if.rc_cb.ReadData2;
    endtask
    
endclass: regfile_monitor


`endif