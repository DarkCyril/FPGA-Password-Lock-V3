/*====================================
* Modified: 5/29/2026
* Description: TestBench For Password
*						lock
=======================================*/

`timescale 1ns/1ps

module password_fsm_tb();

reg clk;
reg rst_n;
reg enter;
reg ticks;
reg mode;
reg [3:0] pin_in;

wire [9:0] led;

password_fsm DUT (	.clk(clk),
							.rst_n(rst_n),
							.mode(mode),
							.enter(enter),
							.ticks(ticks),
							.pin_in(pin_in),
							.led(led)
							);


initial clk = 1'b0;
always #5 clk = ~clk; 

initial begin
   // ---- Reset --> S_IDLE ----
   rst_n = 1'b0;
   enter = 1'b0;
   mode  = 1'b0;
   ticks = 1'b0;
   pin_in = 4'b0000;
   #10;
   rst_n = 1'b1;
   #20;
	
	//Test 1 --> Make new password (S_SET) [X]
	enter = 1'b1;
	mode = 1'b1;
	pin_in = 4'b1111;
	#10;
	enter = 1'b0;
	#20;
	
	//Test 2 --> Return to S_IDLE
	mode = 1'b0;
	enter = 1'b1;
	#10;
	enter = 1'b0;
	#20;
	
	//Test 3 --> S_INPUT
	enter = 1'b1;
	mode = 1'b0;
	pin_in = 4'b1111;
	#10;
	enter = 1'b0;
	#20;
	
	//Test 4 --> S_CHK --> RIGHT PIN --> UNBLK --> S_IDLE
	enter = 1'b1;
	#10;
	enter = 1'b0;
	#20
	
	//Test 5 -->S_IDLE --> S_INPUT --> S_CHK --> Wrong PIN --> BLK
	pin_in = 4'b0000; //Wrong pin
	mode = 1'b0;
	enter = 1'b1; //S_IDLE
	#10;
	enter = 1'b0;
	#20
	mode = 1'b0; //S_Input
	enter = 1'b1; 
	#10;
	enter = 1'b0; //S_BLK
	#20
	enter = 1'b1;
	ticks = 1'b1; //Time Out --> Lets S_Blk --> S_IDLE;
	#10;
	enter = 1'b0;
	#20;
	
	pin_in = 4'b0000; //Wrong pin
	mode = 1'b0;
	enter = 1'b1; //S_IDLE
	#10;
	enter = 1'b0;
	#20
	mode = 1'b0; //S_Input
	enter = 1'b1; 
	#10;
	enter = 1'b0; //S_BLK
	#20
	enter = 1'b1;
	ticks = 1'b1; //Time Out --> Lets S_Blk --> S_IDLE;
	#10;
	enter = 1'b0;
	#20;
	
	
	pin_in = 4'b0000; //Wrong pin
	mode = 1'b0;
	enter = 1'b1; //S_IDLE
	#10;
	enter = 1'b0;
	#20
	mode = 1'b0; //S_Input
	enter = 1'b1; 
	#10;
	enter = 1'b0; //S_BLK
	#20
	enter = 1'b1;
	ticks = 1'b1; //Time Out --> Lets S_Blk --> S_IDLE;
	#10;
	enter = 1'b0;
	#20;
	
	pin_in = 4'b0000; //Wrong pin
	mode = 1'b0;
	enter = 1'b1; //S_IDLE
	#10;
	enter = 1'b0;
	#20
	mode = 1'b0; //S_Input
	enter = 1'b1; 
	#10;
	enter = 1'b0; //S_BLK
	#20
	enter = 1'b1;
	ticks = 1'b1; //Time Out --> Lets S_Blk --> S_IDLE;
	#10;
	enter = 1'b0;
	#20;
	
	rst_n = 1'b0;
	#20;
end

endmodule
