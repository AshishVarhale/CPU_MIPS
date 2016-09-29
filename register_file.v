// register file has 32 32-bit registers, 

module register_file(clk, rst, rd_addr1, rd_addr2, wr_addr, wr_data, rd_data1, rd_data2, RegWrite);

	input clk;
	input rst;
	input RegWrite;
	input [4:0] rd_addr1;
	input [4:0] rd_addr2;
	input [4:0] wr_addr;
	input [31:0] wr_data;
	
	output [31:0] rd_data1;
	output [31:0] rd_data2;
	
	
	reg [31:0] registers [0:31]; 
	
	// reset operation:
	
	integer i;
	
	always @ (negedge clk or posedge rst)
	begin
		if (rst)
		begin
			for(i = 0; i < 32; i = i + 1)
				
				registers[i] <= 32'd0;
		end
		
		else
			
			if(RegWrite && wr_addr !== 5'd0) // Value of $0 register is always 0, not modifiable
				registers[wr_addr] <= wr_data;
		
	
	end
	
	// Outputs
	
	assign rd_data1 = registers[rd_addr1];
	assign rd_data2 = registers[rd_addr2];
	
endmodule