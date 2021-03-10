module InstructionMemory(clk,adr,data);
input clk;
    input[31:0] adr;
    output reg [31:0] data;
    reg[31:0] memory[0:16000];
    initial begin
      $readmemb("test1.txt",memory);//enter file name
    end
	
    always@(adr)begin
      data = memory[{2'b00,adr[31:2]}];
    end
endmodule