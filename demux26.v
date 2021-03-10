module demux26(inp,s,out1,out2);
input s;
input[31:0] inp;
output reg [25:0] out1,out2;
always@(inp)begin
  if(s) out2 = inp[25:0];
  else out1 = inp[25:0];
end
endmodule