`ifndef TRANSACTION
`define TRANSACTION

//  Class: regfile_transaction
//
class regfile_transaction extends uvm_squence_item;
    rand bit [4:0] ReadAddr1, ReadAddr2, WriteAddr;
    rand bit [31:0] WriteData;
    rand bit regfileWrite;
    bit [31:0] ReadData1, ReadData2; 

    `uvm_object_utils_begin(regfile_transaction)
        `uvm_field_int(ReadAddr1, UVM_ALL_ON)
        `uvm_field_int(ReadAddr2, UVM_ALL_ON)
        `uvm_field_int(WriteAddr, UVM_ALL_ON)
        `uvm_field_int(WriteData, UVM_ALL_ON)
        `uvm_field_int(ReadData1, UVM_ALL_ON)
        `uvm_field_int(ReadData2, UVM_ALL_ON)
        `uvm_field_int(regWrite, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "regfile_transaction", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    constraint RA1 {ReadAddr1 inside {[0:(1<<5)-1]};}
    constraint RA2 {ReadAddr2 inside {[0:(1<<5)-1]};}
    constraint WA  {WriteAddr inside {[0:(1<<5)-1]};}
    constraint WD  {WriteData inside {[0:(1<<32)-1]};}
    constraint regWrite {regWrite inside {[0:1]};}

    
endclass: regfile_transaction


`endif