module memorycontrol(code,source1,source2,rw,LDRsel,bussel,databus,addbus,LDRdata, en, result);
input [31:0] code;
output reg rw;
input [31:0] source1,source2, result;
output reg LDRsel, bussel, en;
output reg [31:0] databus;
output reg [31:0]  LDRdata;
output reg	[15:0]	addbus=0;
wire [3:0] operation;
assign operation=code[27:24];
initial
begin
databus=32'b00000000000000000000000000000000;
en=1;
rw=1;
LDRdata=32'b00000000000000000000000000000000;
end
always@(*) 
begin
	 if(operation==4'b0110) //move constant value from code
		begin
		 LDRdata=code[18:3];
		LDRsel=1;
	
		end


	 else
	 if(operation==4'b0111) //move R2 into R1
		begin
		 LDRdata=source2;
		LDRsel=1;

		end
		else
 	if(operation==4'b1001) //Load R2 with the contents at memory address R1
		begin
		 addbus=source1;
		rw=1;
		en=1;
		LDRsel=1;

		end
		else
 	if(operation==4'b1010) //Store R2 at memory address R1
		begin
		 addbus<=source1;
		 databus<=source2;
		rw=0;
		en=1;
		LDRsel=0;
		end
		else
		if((operation!=4'b1111)&(operation!=4'b1000)&(result!==32'bz))
		begin
		LDRdata<=result;
		LDRsel=1;
	
		end
	else
	begin
		LDRsel=0;
		end
end
endmodule

module programcounter(counter,reset,code);
input reset;
input [31:0] code;
output reg [15:0] counter;
initial
begin
counter=-1;

end

assign	counter=counter+1;


endmodule