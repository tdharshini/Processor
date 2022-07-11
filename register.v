module register(code,LDRdata, LDRsel, source1, source2);
input [31:0] code;
input [31:0] LDRdata;
input LDRsel;
reg [31:0] r0=0, r1=1, r2=2, r3=3, r4=4, r5=5, r6=6, r7=7, r8=8, r9=9, r10=10, r11=11, r12=12, r13=13, r14=14, r15 =15;
output reg [31:0] source1, source2;
wire [3:0] destination;
assign destination=code[22:19];
initial
begin

end

always@(*)
begin


		
		case(code[18:15])	//read selected source 2
		4'b0000: source2=r0;
		4'b0001: source2=r1;
		4'b0010: source2=r2;
		4'b0011: source2=r3;
		4'b0100: source2=r4;
		4'b0101: source2=r5;
		4'b0110: source2=r6;
		4'b0111: source2=r7;
		4'b1000: source2=r8;
		4'b1001: source2=r9;
		4'b1010: source2=r10;
		4'b1011: source2=r11;
		4'b1100: source2=r12;
		4'b1101: source2=r13;
		4'b1110: source2=r14;
		4'b1111: source2=r15;
		endcase
		case(code[14:11])	//read selected source 1
		4'b0000: source1=r0;
		4'b0001: source1=r1;
		4'b0010: source1=r2;
		4'b0011: source1=r3;
		4'b0100: source1=r4;
		4'b0101: source1=r5;
		4'b0110: source1=r6;
		4'b0111: source1=r7;
		4'b1000: source1=r8;
		4'b1001: source1=r9;
		4'b1010: source1=r10;
		4'b1011: source1=r11;
		4'b1100: source1=r12;
		4'b1101: source1=r13;
		4'b1110: source1=r14;
		4'b1111: source1=r15;
		endcase
		end
always@(LDRsel or LDRdata or destination) 		
	begin
	if(LDRsel)
	begin
	 case(destination)	//write to selected register
		4'b0000: r0=LDRdata;
		4'b0001: r1=LDRdata;
		4'b0010: r2=LDRdata;
		4'b0011: r3=LDRdata;
		4'b0100: r4=LDRdata;
		4'b0101: r5=LDRdata;
		4'b0110: r6=LDRdata;
		4'b0111: r7=LDRdata;
		4'b1000: r8=LDRdata;
		4'b1001: r9=LDRdata;
		4'b1010: r10=LDRdata;
		4'b1011: r11=LDRdata;
		4'b1100: r12=LDRdata;
		4'b1101: r13=LDRdata;
		4'b1110: r14=LDRdata;
		4'b1111: r15=LDRdata;
		endcase
	end
	
end

endmodule