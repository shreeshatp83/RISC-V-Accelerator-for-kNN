`include "bram_data.v"
`include "bram_label.v"
`include "REG_FILE.v"
`include "alu_test.v"

module DATAPATH(
    input [4:0]read_reg_num1,
    input [4:0]read_reg_num2,
    input [4:0]write_reg,
    input [3:0]alu_control,
    input regwrite,
    input clock,
    input reset,
    output reg[31:0] ar,
    input [11:0]imm,
    input bram_en_mem,
    input bram_en_lab,
    input alu_enable,
    output is_greater_than,
    input imm_value_enable,
    input [9:0]cnt,
    input imm_flw
);

    // Declaring internal wires that carry data
    wire [31:0]read_data1;
    wire [31:0]read_data2;
    wire [31:0]write_data;
    wire [31:0]mem_data;
    wire [31:0]lab_data;
    wire [31:0] data;
    wire [31:0] final_read_data2;
    wire [7:0] imm_final;
    
    bram_data data_memory( clock,bram_en_mem,imm_final,mem_data);
    
    bram_label label_memory(clock,bram_en_lab,imm_final,lab_data);
    
    assign data = (alu_enable==1)? write_data: (bram_en_mem ? mem_data: lab_data);
    
    assign final_read_data2 = (imm_value_enable == 1)?({20'd0,imm}) :read_data2;
    
    assign imm_final = (imm_flw == 1)? read_data1[7:0] : imm[7:0];
    
    // Instantiating the register file
    REG_FILE reg_file_module(read_reg_num1,read_reg_num2,write_reg,data,read_data1,read_data2,regwrite,clock,reset);
    
    // Instanting ALU
    alu_test #(1,1) custom_alu(clock,alu_enable,read_data1, final_read_data2, alu_control, write_data, is_greater_than, cnt);
    
	 always@(posedge clock)
	 begin
//        $display("DATAPATH: imm_final = %d, data = %h, read_data1 = %h, read_data2 = %h, final_read_data2 = %h, write_data = %h, imm_value_enable = %b ,imm_flw = %b, lab_data = %h , mem_data = %h, ", imm_final, data, read_data1, read_data2, final_read_data2, write_data, imm_value_enable,imm_flw, lab_data, mem_data);
	   ar<=write_data;
	 end
endmodule