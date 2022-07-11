module ram(en,rw, addr, datain,dataout);

parameter A = 16;
parameter W = 32;

input en,rw;
input [W-1:0] datain;
input [A-1:0] addr;
output [W-1:0] dataout;
reg [W-1:0] dataout;

reg [W-1:0] mem [0:((A**2)-1)];
initial
begin

mem[0]=32'b00000110001100000000000001001000;
mem[1]=32'b00000110001110000000000001001000;
mem[2]=32'b00000001110000110011100000000000;
mem[3]=32'b00000101010010110011100000000000;
mem[4]=32'b00001000000001000100100000000000;
mem[5]=32'b00010000010101000100100000000000;
mem[6]=32'b00000101010110110011100010000011;
mem[7]=32'b00001001011000000100000000000000;
mem[8]=32'b00001010000001011100100000000000;
end
always @ (*)
begin
if(en)
	if (rw)
		dataout <= mem[addr];  // Read 
	else
		mem[addr] <= datain;   // Write
else
	dataout <= {W{1'bz}}; // High impedance 
end

endmodule
