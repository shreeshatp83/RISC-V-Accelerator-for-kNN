module CONTROL(
   input [31:0] inst_code,
   input [9:0] cnt,
   output reg [3:0] alu_control,
   output reg regwrite_control,
   output reg [11 :0] imm, 
   output reg bram_en_mem,
   output reg bram_en_lab,
   output reg alu_enable,
   output reg pc_branch,
   output reg imm_value_enable,
   output reg imm_flw
);


    reg[6:0] opcode;

    always @( opcode or inst_code)
    begin
            opcode <=  inst_code[6:0];
            case (opcode)
                7'b0000011:  // integer_load
                begin
                    pc_branch <=0;
                    alu_enable<=0;
                    alu_control <= 4'b1111; // alu_enable is zero, so give as 1111
                    regwrite_control <= 1;                    
                    imm <= inst_code[31:20];
                    imm_value_enable <=0;
                      imm_flw <=0;
                   
                                       
                    if(inst_code[14:12] == 3'b000)      //bram_mem load
                    begin                        
                        bram_en_mem <= 1; 
                        bram_en_lab <= 0; 
                                                              
                    end
                    else 
                    if(inst_code[14:12] == 3'b011)      //bram_lab load
                    begin 
                        bram_en_lab <= 1;
                        bram_en_mem <= 0;
                       
                    end 

                end                  
                7'b0010011 :   // integer add
                begin
                    pc_branch <=0;
                    alu_enable<=1;
                  
                    bram_en_mem <= 0;
                    bram_en_lab <= 0;
                    imm_flw <=0;  
                                                                             
                    if(inst_code[14:12]== 3'b000)   //addi
                    begin  
                        alu_control <= 4'b1100;
                        imm <= inst_code[31:20];
                        imm_value_enable <=1;
                        regwrite_control <= 1;
                    end
                    
                    if(inst_code[14:12]== 3'b011)   //move sqrt value
                    begin
                        alu_control <= 4'b0100;
                        imm_value_enable <=0;
                        regwrite_control <= 0;
                    end
                    
                    if(inst_code[14:12]== 3'b001)  // move k
                    begin
                        alu_control <= 4'b0101;
                        imm_value_enable <= 0;
                        regwrite_control <= 0;
                    end
                    if(inst_code[14:12]== 3'b010) // mov lab
                    begin
                        alu_control <= 4'b0101;
                        imm_value_enable <= 0;
                        regwrite_control <= 0;
                    end
                  end
                  
             7'b0000111 : 
             begin
                    pc_branch <=0;   //  load floating point
                    alu_enable<=0;
                    alu_control <= 4'b1111;
                    regwrite_control <= 1;
                    imm <= inst_code[31:20];
                    imm_value_enable <= 0;
                    imm_flw <=1;
//                    bram_en_mem <= 1;
//                    bram_en_lab <= 0;

                    if(inst_code[14:12] == 3'b010)      //bram_mem load
                    begin                        
                        bram_en_mem <= 1; 
                        bram_en_lab <= 0; 
                                                              
                    end
                    else 
                    if(inst_code[14:12] == 3'b011)      //bram_lab load
                    begin 
                        bram_en_lab <= 1;
                        bram_en_mem <= 0;
                       
                    end 
                    
                  
                    
             end
             
             7'b1010011:    // float arithmetic
             begin   
                alu_enable<=1;
                pc_branch <=0;
                bram_en_mem <= 0;
                bram_en_lab <= 0;
                regwrite_control <= 1;
                imm_value_enable <= 0;
                imm_flw <=0;
                imm <= 0;
                                
                if(inst_code[31:27]== 5'b00000) 
                begin  // sub_mul
                  alu_control <= 4'b0000;                  
                end
                
                if(inst_code[31:27]== 5'b00001) 
                begin
                  alu_control <= 4'b0001;   //f_add
                end
                
                if(inst_code[31:27]== 5'b00010) 
                begin
                  alu_control <= 4'b0010;   //f_sqrt
                end
             end
              
              7'b1100011 :   //blt
              begin 
                    alu_enable<=1;
                    pc_branch <=1;
                    alu_control <= 4'b1011;
                    regwrite_control <= 0;
                    bram_en_mem <= 0;
                    bram_en_lab <= 0;
                    imm_value_enable <= 0;
                    imm_flw <=0;
                    imm <= {inst_code[31],inst_code[7],inst_code[30:25],inst_code[11:8]};
              end
           endcase
//           $display("CONTROL: opcode = %b, alu_control = %b, regwrite_control = %b, imm = %h, bram_en_mem = %b, bram_en_lab = %b, alu_enable = %b, pc_branch = %b, imm_value_enable = %b", opcode, alu_control, regwrite_control, imm, bram_en_mem, bram_en_lab, alu_enable, pc_branch, imm_value_enable);

      end

endmodule