module control_unit(Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

	input [5:0] Opcode;
	
	
	output reg RegDst;
	output reg Branch;
	output reg MemRead;
	output reg MemtoReg;
	output reg [1:0] ALUOp;
	output reg  MemWrite;
	output reg ALUSrc;
	output reg RegWrite;
	
	always @ (*)
	begin
		
		// Defaults to R-type instr
		RegDst = 1'b1;
		ALUSrc = 1'b0;
		MemtoReg = 1'b0;
		RegWrite = 1'b1;
		MemRead = 1'b0;
		MemWrite = 1'b0;
		Branch = 1'b0;
		ALUOp = 2'b10;
		
		
		
		
		case(Opcode)
		
			6'd0: ;// R-type
			
			6'd35: begin // LW
			
					RegDst = 1'b0;
					ALUSrc = 1'b1;
					MemtoReg = 1'b1;
					MemRead = 1'b1;
					ALUOp = 2'b00;
					
					end
					
			6'd43: begin // SW
			
					ALUSrc = 1'b1;
					RegWrite = 1'b0;
					MemWrite = 1'b1;
					ALUOp = 2'b00;
					
					end
					
			6'd4 : begin // Beq
					
					RegWrite = 1'b0;
					Branch = 1'b1;
					ALUOp = 2'b01;
					
					
					end
					
		endcase
		
	end
	
endmodule
			