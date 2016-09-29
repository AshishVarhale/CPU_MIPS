module ALU_32bit(control, in1, in2, result, overflow, zero);

input [3:0] control;
input [31:0] in1, in2;

output reg [31:0] result;
output reg overflow;
output zero;

reg add_sub;
reg [31:0] input1, input2;
wire [31:0] Sum;
wire Cout, Ov;


addSub_32bit addSub (input1, input2, add_sub, Sum, Cout, Ov);

assign zero = (result == 0) ? 1:0;


always @ (control)
begin
	
	overflow = 0;
	
	case (control)
		
		4'b0000: // AND
			begin
				result = in1 & in2;
				overflow = 0;
					
			end
		
		4'b0001: //OR
			begin
				result = in1 | in2;
				overflow = 0;
				
			end
		
		4'b0010: //ADD
			begin
				input1 = in1;
				input2 = in2;
				add_sub = 1'b0;
				result = Sum;
				overflow = Ov;
			end
			
		4'b0110: //SUB
			begin	
				input1 = in1;
				input2 = in2;
				add_sub = 1'b1;
				result = Sum;
				overflow = Ov;
			end
			
		4'b0111: //SET ON LESS THAN
			begin
				result = (in1 < in2) ? -1 : 0;
				overflow = 0;
			end
			
		4'b1100: // NOR
			begin
				result = ~(in1 | in2);
				overflow = 0;
			end
		endcase
	end
	
endmodule
				
		