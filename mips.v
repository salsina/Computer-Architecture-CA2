module mips(clk,rst,Jsel,Jrsel,regwrite,RegDst,ALUsrc,PCSrc,ALU_operation,MemRead,MemWrite,MemToReg,zero,OPC,Func);
    input clk,rst,Jsel,regwrite,RegDst,ALUsrc,PCSrc,MemRead,MemWrite,MemToReg,Jrsel;
    input [2:0] ALU_operation;
    output wire zero;
    output reg[5:0] OPC,Func;
    wire[4:0] writereg,RegDst_out;
    wire[31:0] se26_or_pc4,memtoreg_out,Jrsel_input,rd2_or_se,ReadData,ALUresult,add_4_shift_out,add_4_out,after_shift,after_se,se_26_out,se_16_out,readdata1,
     readdata2,pc_input,pc_output,instruction_data,non_jal_output,jal_output,writedata;
    pc PC(pc_input,clk,rst,pc_output);
    InstructionMemory InstMem(clk,pc_output,instruction_data);
	always@(instruction_data) begin
 		OPC = instruction_data[31:26];
    	Func = instruction_data[5:0];
	end
    mux5bit MUX5_1(instruction_data[20:16],instruction_data[15:11],RegDst,RegDst_out);
    mux5bit MUX5_2(RegDst_out,31,Jsel,writereg);
    SE1632 S_E_1632(instruction_data[15:0],se_16_out);
    SE2632 S_E_2632(instruction_data[25:0],se_26_out);
    mux32 MUX32_1(se_16_out,se_26_out,Jsel,after_se);
    mux32 MUX32_4(readdata2,after_se,ALUsrc,rd2_or_se);
    ALU alu(readdata1,rd2_or_se,ALU_operation,zero,ALUresult);
    RegisterFile RF(clk,rst,regwrite,instruction_data[25:21],instruction_data[20:16],writereg,writedata,readdata1,readdata2);
    mux32 MUX32_7(add_4_out,after_shift,Jsel,se26_or_pc4);
    Adder add_2(se26_or_pc4,after_shift,add_4_shift_out);
    Adder add_1(4,pc_output,add_4_out);
    twobitshifter shifter(after_se,after_shift);
    mux32 MUX32_6(memtoreg_out,add_4_out,Jsel,writedata);
    mux32 MUX32_2(se26_or_pc4,add_4_shift_out,PCSrc,Jrsel_input);
    mux32 MUX32_3(Jrsel_input,readdata1,Jrsel,pc_input);
    DataMemory DataMem(clk,rst,ALUresult,readdata2,MemRead,MemWrite,ReadData);
    mux32 MUX32_5(ReadData,ALUresult,MemToReg,memtoreg_out);
	

endmodule