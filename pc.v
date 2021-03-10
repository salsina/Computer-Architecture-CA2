module pc(inp,clk,rst,out);
    input clk,rst;
    input [31:0] inp;
    output reg [31:0] out;
    always@(posedge clk,posedge rst)begin
        if(rst) out <={30'b111111111111111111111111111111,2'b0};
        else out <= inp;
    end
endmodule