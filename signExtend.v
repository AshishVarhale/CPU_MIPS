module signExtend(in_offset, out_offset);

	input [15:0] in_offset;
	
	output [31:0] out_offset;
	
  assign out_offset[31:16] = {16{in_offset[15]}};
  assign out_offset[15:0] = in_offset;
	
	endmodule