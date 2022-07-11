module alu(A, B, Op_code, LS, Cond, S, N,Z,C,V, y3,rotbit);
input [31:0] A,B; 
input [3:0] Op_code, Cond;
input [2:0] LS;
input S; 
wire [31:0] Y, y2; 
inout reg [31:0]  y3; 
wire G,L,E,UG,UL,ca;
inout reg N,Z,C,V;
input[4:0] rotbit;
    rshift r1(y2,y3, LS,rotbit);
 
    add32 add1(A,B,Op_code,Y,Cond,N,Z,C,V,S,ca);
    sub32 sub1(B,A,Op_code,Y,Cond,N,Z,C,V,S,ca);
    mul32 mul1(A,B,Op_code,Y,ca);
    or32 or1(A,B,Op_code,Y);
    and32 and1(A,B,Op_code,Y);
    xor32 xor1(A,B,Op_code,Y);
    cop32 cop1(Y,B,Op_code);
	noop noop1(Y,Op_code,B);
	flagging flaggy(A,B,Y,Op_code,Cond,N,Z,C,V,S,ca);
	checky check1(Y,Cond,N,Z,C,V,S,y2);
     


endmodule


module add32(a,b,Op_code,Y,Cond,N,Z,C,V,S,ca);
input [31:0] a, b;
input [3:0] Op_code,Cond;
inout reg N,Z,C,V;
output reg ca;
input S;
output reg [31:0] Y; 
always@(*)
begin
if(Op_code[3:0]==4'b0000)
assign {ca,Y}=a+b; 
else 
assign Y=32'bz; 
	end
endmodule


module sub32(a,b,Op_code,Y,Cond,N,Z,C,V,S,ca);
input [31:0]a,b; 
input [3:0] Op_code,Cond;
inout reg N,Z,C,V;
output reg [31:0]Y; 
output reg ca;
input S;
always@(*)
begin
if(Op_code[3:0]==4'b0001)  
assign {ca,Y}=a-b;
else 
assign Y=32'bz;
	end
endmodule


module mul32(a,b,Op_code,Y,ca); 
input [31:0]a,b; 
input [3:0] Op_code;
output reg [31:0]Y; 
output reg ca;
always@(*)
begin
if(Op_code[3:0]==4'b0010) 
assign {ca,Y}=a*b; 
else 
assign Y=32'bz;
end
endmodule

module or32(a,b,Op_code,y);
input [31:0]a,b; 
input [3:0] Op_code;
output reg [31:0]y;
always@(*)
begin
if(Op_code[3:0]==4'b0011)   
assign y=a|b; 
else 
assign y=32'bz;
end
endmodule

module and32(a,b,Op_code,y); 
input [31:0]a; 
input [31:0]b; 
input [3:0] Op_code;
output reg [31:0]y;
always@(*)
begin
if(Op_code[3:0]==4'b0100)  
assign y=a&b; 
else 
assign y=32'bz;
end
endmodule

module xor32(a,b,Op_code,y); 
input [31:0]a; 
input [31:0]b; 
input [3:0] Op_code;
output reg [31:0]y; 
always@(*)
begin
if(Op_code[3:0]==4'b0101) 
assign y=a^b; 
else 
assign y=32'bz;
end
endmodule

module rshift(a,b,LS,rotbit); 
input [4:0] rotbit;
input [31:0]a;
input [2:0] LS;
output reg [31:0]b; 
always@(*)
begin
if(LS[2:0]==3'b001) 
assign b=a>>rotbit; 
else 
if(LS[2:0]==3'b010) 
assign b=a<<rotbit; 
else
if(LS[2:0]==3'b011) 
assign b=a>>>rotbit; 
else
assign b=a;
end
endmodule 



module cop32(y,b,Op_code);
input [31:0]b; 
input [3:0] Op_code;
output reg [31:0]y;
always@(*)
begin
if(Op_code[3:0]==4'b0111)  
assign y=b;
else 
assign y=32'bz;
end
endmodule

module noop(y,OP_code,b);
input [31:0]b; 
input [3:0] OP_code;
output reg [31:0]y;
always@(*)
begin
if ((OP_code!=4'b0000)&(OP_code!=4'b0001)&(OP_code!=4'b0010)&(OP_code!=4'b0011)&(OP_code!=4'b0100)&(OP_code!=4'b0101)&(OP_code!=4'b0111))
assign y=b;
else
assign y=32'bz;
end
endmodule



 module flagging(a,b,y,Op_code,cond,N,Z,C,V,S,ca);
input [3:0]cond; 
input [3:0] Op_code;
input [31:0] a,b,y;
reg [31:0] test;
input S,ca;
output reg N,Z,C,V;
always@(*)
begin
if(Op_code!=4'b1000)
	begin
	if(S)
	begin	
	if(y==0)
		Z<=1;
		else
		Z<=0;
	if(y[31])
		N<=1;
		else
		N<=0;
	if(ca)
		C<=1;
		else
		C<=0;
	V<=0;
end
end
	else
	begin

	assign test=b-a;


	if(test[31])
		N<=1;
	else
		N<=0;
	if(test==0)
		Z<=1;
	else
		Z<=0;
		
	if	(y[63:32])
		C<=1;
		else
		C<=0;
		V<=0;
	end

end
endmodule	
		
module checky(y,Cond,N,Z,C,V,S,y2);

input [3:0] Cond;
inout reg N,Z,C,V;
input S;
input  [31:0] y; 
output reg [31:0] y2;
always@(*)
	begin
		case(Cond)		//check conditional
	4'b0000:
	begin			
	y2<=y;
	end
	4'b0001:
	begin			//if equal
	if(Z)
		y2<=y;
	end
	4'b0010:
	begin			//if greater than
	if((Z==0)&&(N==V))
		y2<=y;
	end	
	4'b0011:
	begin			//if less than
	if(N!=V)
		y2<=y;
	end
	4'b0100:
	begin			//if greater or equal
	if(N==V)
		y2<=y;
	end
	4'b0101:
	begin			//if less or equal
	if((N!=V)||(Z==1))
		y2<=y;
	end
	4'b0110:
	begin			//if unsigned higher
	if((C==1)&&(Z==0))
		y2<=y;
	end
	4'b0111:
	begin			//if unsigned lower
	if((C==0)||(Z==1))
		y2<=y;
	end
	4'b1000:
	begin			//if unsigned higher or same
	if(N==V)
		y2<=y;
	end
	endcase
	if(y2!=y)
	y2<=32'bz;
	end
	endmodule