`ifndef REG32BIT
`define REG32BIT

`include "uvm_macros.svh"
import uvm_pkg::*;

class reg32bit extends uvm_reg;
    `uvm_object_utils(reg32bit)

    uvm_reg_field field;

    function new(string name = "reg32bit");
        super.new(name, 32, UVM_NO_COVERAGE);
    endfunction

    virtual function void build(uvm_reg_data_t reset_value);
        field = uvm_reg_field::type_id::create("field");
        field.configure(this, 32, 0, "RW", 1, reset_value, 1, 1, 1);
    endfunction
endclass

`endif