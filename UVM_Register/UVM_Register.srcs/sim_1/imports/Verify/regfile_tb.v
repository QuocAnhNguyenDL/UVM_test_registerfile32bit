
module regfile_tb;
    reg clk;
    reg reset;
    reg [4:0] ReadAddr1, ReadAddr2;
    reg [4:0] WriteAddr;
    reg [31:0] WriteData;
    wire RegWrite;
    wire [31:0] ReadData1, ReadData2;
    
    regfileisters r0(
        .clk(clk),
        .reset(reset),
        .ReadAddr1(ReadAddr1),
        .ReadAddr2(ReadAddr2),
        .WriteAddr(WriteAddr),
        .WriteData(WriteData),
        .RegWrite(regWrite),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    initial begin
       clk = 0;
       forever begin #5 clk = ~clk; end
    end
    
    initial begin
        reset = 0;
        #20 reset = 1;
        #25 reset = 0;
    end

endmodule
