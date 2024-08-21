module float_add(
    input en,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] result
);
    reg [23:0] A_Mantissa, B_Mantissa, Temp_Mantissa;
    reg [7:0] A_Exponent, B_Exponent, diff_Exponent, exp_adjust;
    reg A_sign, B_sign, Sign;
    reg carry;
    reg [4:0] leading_zeros;
    reg [23:0] shifted_mantissa;
    reg [7:0] adjusted_exponent;

    // Function to count leading zeros in Temp_Mantissa
    function [4:0] count_leading_zeros(input [23:0] value);
        begin
            count_leading_zeros = (value[23] ? 5'd0 :
                                   value[22] ? 5'd1 :
                                   value[21] ? 5'd2 :
                                   value[20] ? 5'd3 :
                                   value[19] ? 5'd4 :
                                   value[18] ? 5'd5 :
                                   value[17] ? 5'd6 :
                                   value[16] ? 5'd7 :
                                   value[15] ? 5'd8 :
                                   value[14] ? 5'd9 :
                                   value[13] ? 5'd10 :
                                   value[12] ? 5'd11 :
                                   value[11] ? 5'd12 :
                                   value[10] ? 5'd13 :
                                   value[9] ? 5'd14 :
                                   value[8] ? 5'd15 :
                                   value[7] ? 5'd16 :
                                   value[6] ? 5'd17 :
                                   value[5] ? 5'd18 :
                                   value[4] ? 5'd19 :
                                   value[3] ? 5'd20 :
                                   value[2] ? 5'd21 :
                                   value[1] ? 5'd22 :
                                   value[0] ? 5'd23 : 5'd24);
        end
    endfunction

    always @(*) begin
    if(en) begin
        if (A == 32'b0 && B == 32'b0) begin
            // If both inputs are zero, set the result to zero
            result = 32'b0;
        end else begin
            if (A[30:23] >= B[30:23]) begin
                A_Mantissa = {1'b1, A[22:0]};
                A_Exponent = A[30:23];
                A_sign = A[31];

                B_Mantissa = {1'b1, B[22:0]};
                B_Exponent = B[30:23];
                B_sign = B[31];
            end else begin
                A_Mantissa = {1'b1, B[22:0]};
                A_Exponent = B[30:23];
                A_sign = B[31];

                B_Mantissa = {1'b1, A[22:0]};
                B_Exponent = A[30:23];
                B_sign = A[31];
            end

            diff_Exponent = A_Exponent - B_Exponent;
            B_Mantissa = (B_Mantissa >> diff_Exponent);
            {carry, Temp_Mantissa} = (A_sign == B_sign) ? A_Mantissa + B_Mantissa : A_Mantissa - B_Mantissa;
            exp_adjust = A_Exponent;

            if (carry) begin
                Temp_Mantissa = Temp_Mantissa >> 1;
                exp_adjust = exp_adjust + 1'b1;
            end else begin
                leading_zeros = count_leading_zeros(Temp_Mantissa);
                shifted_mantissa = Temp_Mantissa << leading_zeros;
                adjusted_exponent = exp_adjust - leading_zeros;
                Temp_Mantissa = shifted_mantissa;
                exp_adjust = adjusted_exponent;
            end

            Sign = A_sign;
            result = {Sign, exp_adjust, Temp_Mantissa[22:0]};
        end
        end
    end
endmodule
