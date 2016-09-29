
module PC_control(PC_out, signExtend_out, PCSrc, PC_in);

	input [31:0] PC_out;
	input [31:0] signExtend_out;
	input PCSrc; // from control unit
	
	output [31:0] PC_in;
	
	wire [31:0] incr; 
	
	assign incr = PC_out + 4;// increments PC by 4
	
	assign PC_in = PCSrc ? (incr + (signExtend_out << 2)):(incr);
	
	endmodule