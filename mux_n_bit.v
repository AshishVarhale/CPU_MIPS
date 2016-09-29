module mux_n_bit(in1, in2, sel, out);

parameter n = 32;

	input [n-1:0] in1;
	input [n-1:0] in2;
	input sel;
	
	output reg [n-1:0] out;
	
	always @ (*)
	begin
		if (!sel)
			out <= in1;
		else
			out <= in2;
	end
endmodule