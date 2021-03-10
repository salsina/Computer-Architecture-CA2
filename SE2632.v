module SE2632(inp,out);
    input[25:0] inp;
    output reg [31:0] out;
    always@(inp) begin
        if (inp[25] == 0)
            out = {6'b0,inp};
        else
            out = {6'b111111,inp};
    end
endmodule