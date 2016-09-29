module CLA_4bit(A, B, Cin, Sum, PG, GG);
	input [3:0] A, B;
	input Cin;
	output [3:0] Sum;
	output PG, GG; // used to extend the circuit to 32-bit adder
	
	wire [3:0] G, P;
   wire [3:0] C; 
   
 
    assign G = A & B; //Generate
    assign P = A ^ B; //Propagate
	 
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    //assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);
	 
    assign Sum = P ^ C;
    
    assign PG = P[3] & P[2] & P[1] & P[0];
    assign GG = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule