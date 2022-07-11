module processor_tb;

parameter W = 32;
parameter A = 16;
wire [3:0] Op_code, Cond;
reg [W-1:0] dataout;
wire [31:0] Result, source1, source2, datain, LDRdata;
wire [31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
reg [15:0] counter;
initial
begin
counter=0;
#10
counter=1;
#10
counter=2;

#10
counter=3;
#10
counter=4;
#10
counter=5;

#10
counter=6;
#10
counter=7;
#10
counter=8;
#10
counter=9;

#10
counter=10;
#10
counter=11;
#10
counter=12;

#10
counter=13;
#10
counter=14;
#10
counter=15;

#10
counter=16;
 end

initial
begin
$monitor($time, "Source1= %d, Source2= %d, Result= %d, LDRdata= %b, datain= %b", source1, source2, Result, LDRdata, datain);
end

processor test(Result, source1, source2, LDRdata, datain, counter);
	//programcounter county(counter,reset,code);
endmodule
