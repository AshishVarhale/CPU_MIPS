module datapath(clk, rst, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, ALUOp, Opcode, out_data, ALU_result, rd_data1, rd_data2, mux_32_out, signExtend_out, Instructions, PC_out);

	input clk;
	input rst;
	input RegDst;
	input RegWrite;
	input ALUSrc;
	input MemRead;
	input MemWrite;
	input MemtoReg;
	input Branch;
	input [1:0] ALUOp;
	
	output [5:0] Opcode;
	output [31:0] out_data;
	
	output [31:0] ALU_result;///
	output [31:0] rd_data1;///
	output [31:0] rd_data2;///
	output [31:0] mux_32_out;///
	output [31:0] signExtend_out;///
	output [31:0] PC_out;
	//output clk_90;
	
	
	// signal declarations
	
	//PC
	wire [31:0] PC_in;
	wire [31:0] PC_out;
	//wire signExtend_out;
	wire PCSrc;
	
	//Inst mem
	output wire [31:0] Instructions;
	
	assign Opcode = Instructions[31:26];
	wire [5:0] inst25_21 = Instructions[25:21];
	wire [5:0] inst20_16 = Instructions[20:16];
	wire [5:0] inst15_11 = Instructions[15:11];
	wire [15:0] inst15_0 = Instructions[15:0];
	wire [5:0] inst5_0 = Instructions[5:0];
	
	
	// Register file
	
	wire [5:0] wr_addr;
	wire [31:0] wr_data;
	//wire [31:0] rd_data1;
	//wire [31:0] rd_data2;
	//wire [31:0] mux_32_out;
	assign out_data = wr_data;
	
	// ALU
	
	wire [3:0] control;
	wire [31:0] result;
	wire overflow;
	wire zero;
	
	//Data Memory
	
	wire [31:0] dataMemOut;
	//wire locked;
	
	
	
	
	// Component instantiations
	PC pc(PC_in, PC_out, rst, clk);
	signExtend sigXtend(inst15_0, signExtend_out);
	PC_control pcControl(PC_out, signExtend_out, PCSrc, PC_in); //PCSrc
	
	
	Instr_Mem instrMem(PC_out[8:2], Instructions); // PC and inst_mem has clk out of phase
	
	
	mux_n_bit #(5) mux5bit (inst20_16, inst15_11, RegDst, wr_addr);
	register_file regFile(clk, rst, inst25_21, inst20_16, wr_addr, wr_data, rd_data1, rd_data2, RegWrite);
	
	mux_n_bit #(32) mux32bit_1 (rd_data2, signExtend_out, ALUSrc, mux_32_out);
	
	ALU_32bit alu32 (control, rd_data1, mux_32_out, result, overflow, zero);
	ALU_control aluControl(inst5_0, ALUOp, control);
	
	//pll PLL1 (clk, rst, clk_90, locked);
	
	
	data_mem dataMem(result[10:2], clk, rd_data2, MemRead, MemWrite, dataMemOut);
	
	mux_n_bit #(32) mux32bit_2 (result, dataMemOut, MemtoReg, wr_data);

	
	and(PCSrc, Branch, zero);
	
	assign ALU_result = result;
	
	endmodule
	
	


