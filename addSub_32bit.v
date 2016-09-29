


module addSub_32bit(in1, in2, add_sub, Sum, Cout, Ov);
	input [31:0] in1, in2;
	input add_sub; //0 for add, 1 for sub
	output [31:0] Sum;
	output Cout, Ov;
	
	wire [31:0] in2_bar;
	wire c0, c1, c2, c3, c4, c5, c6, c7, c8;
  	wire P0, P1, P2, P3, P4, P5, P6, P7;
  	wire G0, G1, G2, G3, G4, G5, G6, G7;
  	wire Cout_temp;
	
	
	genvar j;
	generate for (j=0; j<32; j=j+1) begin: xor_loop
	xor g1 (in2_bar[j], in2[j], add_sub);
	end 
	endgenerate
	
	xor(Cout, Cout_temp, add_sub); // cout = cout_temp for add, cout = not(cout_temp) for sub
  assign Ov = ~add_sub & (~(in1[31] ^ in2[31])) & (Sum[31] ^ in1[31]); // overflow
	
	assign c0 = add_sub; // initial cin = 0 for add, 1 for sub
	
	assign c1 = G0 | (P0 & c0); // group carry logic for fast CLA adder
	assign c2 = G1 | (P1 & G0) | (P1 & P0 & c0);
	assign c3 = G2 | (P2 & G1) | (P2 & P1 & G0) | (P2 & P1 & P0 & c0);
	assign c4 = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & G0) | (P3 & P2 & P1 & P0 & c0);
	assign c5 = G4 | (P4 & G3) | (P4 & P3 & G2) | (P4 & P3 & P2 & G1) | (P4 & P3 & P2 & P1 & G0) | (P4 & P3 & P2 & P1 & P0 & c0);
	assign c6 = G5 | (P5 & G4) | (P5 & P4 & G3) | (P5 & P4 & P3 & G2) | (P5 & P4 & P3 & P2 & G1) | (P5 & P4 & P3 & P2 & P1 & G0) | (P5 & P4 & P3 & P2 & P1 & P0 & c0);
	assign c7 = G6 | (P6 & G5) | (P6 & P5 & G4) | (P6 & P5 & P4 & G3) | (P6 & P5 & P4 & P3 & G2) | (P6 & P5 & P4 & P3 & P2 & G1) | (P6 & P5 & P4 & P3 & P2 & P1 & G0) | (P6 & P5 & P4 & P3 & P2 & P1 & P0 & c0);
	assign Cout_temp = G7 | (P7 & G6) | (P7 & P6 & G5) | (P7 & P6 & P5 & G4) | (P7 & P6 & P5 & P4 & G3) | (P7 & P6 & P5 & P4 & P3 & G2) | (P7 & P6 & P5 & P4 & P3 & P2 & G1) | (P7 & P6 & P5 & P4 & P3 & P2 & P1 & G0) | (P7 & P6 & P5 & P4 & P3 & P2 & P1 & P0 & c0);
	
	CLA_4bit A1(in1[3:0], in2_bar[3:0], c0, Sum[3:0], P0, G0);
	CLA_4bit A2(in1[7:4], in2_bar[7:4], c1, Sum[7:4], P1, G1);
	CLA_4bit A3(in1[11:8], in2_bar[11:8], c2, Sum[11:8], P2, G2);
	CLA_4bit A4(in1[15:12], in2_bar[15:12], c3, Sum[15:12], P3, G3);
	CLA_4bit A5(in1[19:16], in2_bar[19:16], c4, Sum[19:16], P4, G4);
	CLA_4bit A6(in1[23:20], in2_bar[23:20], c5, Sum[23:20], P5, G5);
	CLA_4bit A7(in1[27:24], in2_bar[27:24], c6, Sum[27:24], P6, G6);
	CLA_4bit A8(in1[31:28], in2_bar[31:28], c7, Sum[31:28], P7, G7);
	
	
	endmodule

