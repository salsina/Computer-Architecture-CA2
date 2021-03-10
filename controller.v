module controller(clk,rst,zero,OPC,ALUsrc,Jsel,regwrite,RegDst,alu_op,MemRead,MemWrite,MemToReg,PCSrc);
    input [5:0] OPC;
    input clk,rst,zero;
    output reg ALUsrc,Jsel,regwrite,RegDst,MemRead,MemWrite,MemToReg;
    output wire PCSrc;
    output reg [1:0] alu_op;
    reg branch,not_branch;
    always@(OPC)begin
        {ALUsrc,Jsel,regwrite,RegDst,MemRead,MemWrite,MemToReg,branch,not_branch} = 9'b0;
        if(OPC == 6'b000000) begin//Rtype
            {RegDst,regwrite,MemToReg} = 3'b111;
            alu_op = 2'b10;
        end
        if(OPC == 6'b001000) begin//addi
            {regwrite,ALUsrc,MemToReg} = 3'b111;
            alu_op = 2'b00;
        end
        if(OPC == 6'b001100) begin//andi
            {regwrite,ALUsrc,MemToReg} = 3'b111;
            alu_op = 2'b11;
        end
        if(OPC == 6'b100011) begin//lw
            {regwrite,ALUsrc,MemRead} = 3'b111;
            alu_op = 2'b00;
        end
        if(OPC == 6'b101011) begin//sw
            {ALUsrc,MemWrite} = 2'b11;
            alu_op = 2'b00;
        end
        if(OPC == 6'b000100) begin//beq
            branch = 1'b1;
            alu_op = 2'b01;
        end
        if(OPC == 6'b000101) begin//bne
            not_branch = 1'b1;
            alu_op = 2'b01;
        end
        if(OPC == 6'b000011) begin//Jal 
            {regwrite,Jsel} = 2'b11;
        end
        if(OPC == 6'b000010) begin//j 
            Jsel = 1'b1;
        end
    end
    assign PCSrc = (branch & zero) | (not_branch & (~zero) ) ;

endmodule