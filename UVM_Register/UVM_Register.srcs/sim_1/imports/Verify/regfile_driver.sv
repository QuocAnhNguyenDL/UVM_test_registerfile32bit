`ifndef DRIVER
`define DRIVER

`include "uvm_macros.svh"
`include "regfile_transaction.sv"
`include "regfile_interface.sv"
import uvm_pkg::*;

class regfile_driver extends uvm_driver#(regfile_transaction);
    `uvm_component_utils(regfile_driver);

    virtual regfile_interface r_if;
    uvm_analysis_port#(regfile_transaction) dr2rm_port;

    function new(string name = "regfile_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual regfile_interface)::get(this,"","r_if",r_if))
            `uvm_fatal("DRV", "COULD NOT GET INTERFACE")
        dr2rm_port = new("dr2rm_port", this);
    endfunction

    task run_phase(uvm_phase phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req);
            drive();
            @(r_if.dr_cb)
                $cast(rsp, req.clone());
                rsp.set_id_info(req);
                dr2rm_port.write(rsp);
                seq_item_port.item_done();
                seq_item_port.put(rsp);
        end
    endtask

    task reset();
        r_if.dr_cb.ReadAddr1 <= 0;
        r_if.dr_cb.ReadAddr2 <= 0;
        r_if.dr_cb.WriteData <= 0;
        r_if.dr_cb.WriteAddr <= 0;
        r_if.dr_cb.RegWrite <= 0;
    endtask

    task drive();
        wait(!r_if.reset)
        @(r_if.dr_cb);
            r_if.dr_cb.ReadAddr1 <= req.ReadAddr1;
            r_if.dr_cb.ReadAddr2 <= req.ReadAddr2;
            r_if.dr_cb.WriteData <= req.WriteData;
            r_if.dr_cb.WriteAddr <= req.WriteAddr;
            r_if.dr_cb.RegWrite <= req.RegWrite;
    endtask
    
endclass: regfile_driver


`endif