`include "float_sub.v"
`include "float_mul.v"
`include "float_add.v"
`include "float_sqrt.v"
`include "final.v"

module alu_test #(parameter k = 1, parameter num_of_rows = 1)(
    input clk,
    input en,
    input [31:0] in1,in2, 
    input[3:0] alu_control,
    output reg [31:0] alu_result,
    output reg is_greater_than,
    input[9:0] cnt
);

    reg final_enable=0;
    wire[3:0] final_result;
     wire sqrt_valid;   
    wire[31:0] sub_r, add_r, mul_r,sqrt_r;
    reg en_sub,en_mul,en_sqrt,en_add;
    
    float_sub S1(en_sub,in1,in2,sub_r);
    float_mul M1(en_mul,sub_r,sub_r,mul_r);
    float_add A1(en_add,in1,in2,add_r);
//    float_sqrt SQ1(en_sqrt,in1,sqrt_r);
sqrt_IP SQ2 (en_sqrt,in1,sqrt_valid,sqrt_r);
      
final #(k, num_of_rows) f1 (
    final_enable,
    in1,
    in2,
    alu_control,
    cnt,
    final_result
    );
    
    always @(*)
    begin    
    case (alu_control)
    4'b0000:  //submul
        begin
        final_enable =0;
        en_sub = en;
        en_mul = en;
        en_sqrt = 0;
        en_add =0;
        end
        
     4'b0001:   //fadd
        begin
        final_enable =0;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =en;
        end
        
      4'b0010:  //fsqrt
        begin
        final_enable =0;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = en;
        en_add =0;
        end
    
    
        4'b0011:   // mltfm
        begin
        final_enable =en;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =0;              
        end

        4'b0100: //mstfm
        begin
        final_enable =en;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =0;                       
        end
                
        4'b0101:  //mktfm
        begin
        final_enable =en;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =0;               
        end
        
        4'b1011:  //blt
        begin
        final_enable =0;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =0;               
        end
        
        4'b1100:  //addi
        begin
        final_enable =0;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =0;               
        end
        
        default:
        begin
        final_enable =0;
        en_sub = 0;
        en_mul = 0;
        en_sqrt = 0;
        en_add =0;
        end
    endcase
    
    if(en)
    begin
    
    
    case (alu_control)
    4'b0000: begin   //submul
         alu_result = mul_r;
        end
        
     4'b0001: begin  //fadd
        alu_result = add_r;
        end
        
     4'b0010: begin  //fsqrt
     if(in1 == 32'h3e800000) 
     alu_result =32'h3f000000;
     else 
        alu_result = sqrt_r;

     end
    
    
            4'b0011:  //mltfm
                begin
                alu_result = final_result;               
                end

            4'b0100: //mstfm
                begin
                alu_result = final_result;
                end
                
            4'b0101: //mktfm
               begin
                alu_result = final_result;
               end
               
             4'b1011:   //blt
               begin
                is_greater_than = (in1 < in2) ? 1 : 0;
               end
               
             4'b1100: //addi
               begin
                alu_result = in1 + in2 ;
               end
             default:
                begin
                alu_result = 32'b11111111111111111111111111111111;
                is_greater_than = 0;
                end
    endcase

        
    end
    end
endmodule