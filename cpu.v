module cpu(clk, rst, out_data, ALU_result, rd_data1, rd_data2, mux_32_out, signExtend_out,Instructions, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, ALUOp, PC_out);
	
	input clk;
	input rst;
	
	output [31:0] out_data;
	
	output [31:0] ALU_result;
		output [31:0] rd_data1;///
	output [31:0] rd_data2;///
	output [31:0] mux_32_out;///
	output [31:0] signExtend_out;///
	output RegDst;
	output RegWrite;
	output ALUSrc;
	output MemRead;
	output MemWrite;
	output MemtoReg;
	output Branch;
	output [1:0] ALUOp;
	output [31:0] Instructions;
	output [31:0] PC_out;
	//output clk_90;

	
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
	
	datapath DP(clk, rst, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, ALUOp, Opcode, out_data, ALU_result, rd_data1, rd_data2, mux_32_out, signExtend_out,Instructions, PC_out);
	
	control_unit CU(Opcode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
	
	
	
endmodule