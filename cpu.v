module cpu(clk, rst, out_data);//,  ALU_result, mux_32_out, rd_data1, rd_data2, signExtend_out, PC_out, Instructions);
	
	input clk;
	input rst;
	
	output [31:0] out_data;
	
	
/*
	output [31:0] ALU_result; // For debug
	output [31:0] mux_32_out;
	output [31:0] rd_data1;
	output [31:0] rd_data2;
	output [31:0] signExtend_out;
	output [31:0] PC_out;
	output [31:0] Instructions;
	*/
	//Signal Declarations:
	
	wire RegDst;
	wire RegWrite;
	wire ALUSrc;
	wire MemRead;
	wire MemWrite;
	wire MemtoReg;
	wire Branch;
	wire [1:0] ALUOp;
	wire [5:0] Opcode;
	wire [31:0] out_data;
	
	
	// Instantiations
	
	datapath DP(clk, rst, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, ALUOp, Opcode, out_data);//,  ALU_result, mux_32_out, rd_data1, rd_data2, signExtend_out, PC_out, Instructions);
	
	control_unit CU(Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
	
	
	
endmodule