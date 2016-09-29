module ALU_control(funct, ALUop, control);
	
	input [5:0] funct;
	input [1:0] ALUop;
	
	output reg [3:0] control;
	
	always @ (*)
	begin
		case(ALUop) 
			
			2'b00: control = 4'b0010;
			
			2'b01: control = 4'b0110;
			
			2'b10: case(funct) 
					
						6'h20: control = 4'b0010;
						
						6'h22: control = 4'b0110;
						
						6'h24: control = 4'b0000;
						
						6'h25: control = 4'b0001;
						
						6'h2A: control = 4'b0111;
						
						6'h27: control = 4'b1100;
						
						default: control = 4'b0000; //default to AND
						
					endcase
						
			default: control = 4'b0000;//default to AND
			
		endcase
		
	end
endmodule
					
					