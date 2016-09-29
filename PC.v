// connnect this module to Output of PC_control

module PC(PC_inAddr, PC_outAddr, rst, clk);

	input [31:0] PC_inAddr;
	input clk;
	input rst;
	
	output reg [31:0] PC_outAddr;
	
	always@(negedge clk or posedge rst)
	begin
		if (rst)
		
			PC_outAddr <= 32'd0;
			
		else
		
			PC_outAddr <= PC_inAddr;
			
	end
	
	endmodule