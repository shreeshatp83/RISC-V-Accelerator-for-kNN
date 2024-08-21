module float_div( input en,       input [31:0]A,
                         input [31:0]B,
                         output [31:0] result);
reg overflow;
reg underflow;
reg exception;                         
reg [23:0] A_Mantissa,B_Mantissa;
reg [22:0] Mantissa;
wire [7:0] exp;
reg [23:0] Temp_Mantissa;
reg [7:0] A_Exponent,B_Exponent,Temp_Exponent,diff_Exponent;
wire [7:0] Exponent;
reg [7:0] A_adjust,B_adjust;
reg A_sign,B_sign,Sign;
reg [32:0] Temp;
wire [31:0] temp1,temp2,temp3,temp4,temp5,temp6,temp7,debug;
wire [31:0] reciprocal;
wire [31:0] x0,x1,x2,x3;
reg [6:0] exp_adjust;
reg [31:0] B_scaled; 
reg en1,en2,en3,en4,en5;
reg dummy;
/*----Initial value----*/
float_mul M1(.en(en),.A({{1'b0,8'd126,B[22:0]}}),.B(32'h3ff0f0f1),.result(temp1)); //verified
assign debug = {1'b1,temp1[30:0]};
float_add A1(.en(en),.A(32'h4034b4b5),.B({1'b1,temp1[30:0]}),.result(x0));

/*----First Iteration----*/
float_mul M2(.en(en),.A({{1'b0,8'd126,B[22:0]}}),.B(x0),.result(temp2));
float_add A2(.en(en),.A(32'h40000000),.B({!temp2[31],temp2[30:0]}),.result(temp3));
float_mul M3(.en(en),.A(x0),.B(temp3),.result(x1));

/*----Second Iteration----*/
float_mul M4(.en(en),.A({1'b0,8'd126,B[22:0]}),.B(x1),.result(temp4));
float_add A3(.en(en),.A(32'h40000000),.B({!temp4[31],temp4[30:0]}),.result(temp5));
float_mul M5(.en(en),.A(x1),.B(temp5),.result(x2));

/*----Third Iteration----*/
float_mul M6(.en(en),.A({1'b0,8'd126,B[22:0]}),.B(x2),.result(temp6));
float_add A4(.en(en),.A(32'h40000000),.B({!temp6[31],temp6[30:0]}),.result(temp7));
float_mul M7(.en(en),.A(x2),.B(temp7),.result(x3));

/*----Reciprocal : 1/B----*/
assign Exponent = x3[30:23]+8'd126-B[30:23];
assign reciprocal = {B[31],Exponent,x3[22:0]};

/*----Multiplication A*1/B----*/
float_mul M8(.en(en),.A(A),.B(reciprocal),.result(result));
endmodule
