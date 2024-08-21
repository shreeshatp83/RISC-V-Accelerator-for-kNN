`include "CONTROL.v"
`include "DATAPATH.v"
`include "IFU.v"

module PROCESSOR( 
    input clock, 
    input reset,
    output [31:0]ar
);

    wire [31:0] instruction_code;
    wire [3:0] alu_control;
    wire regwrite;
    wire bram_en_mem, bram_en_lab,alu_enable;
    wire [11:0]imm;
    wire pc_branch;
    wire is_greater_than;
    wire imm_value_enable;
    wire [9:0] cnt;
    wire imm_flw;

    IFU IFU_module(clock, reset, pc_branch, is_greater_than, imm, instruction_code, cnt);
	
    CONTROL control_module(instruction_code,cnt, alu_control, regwrite,imm,bram_en_mem,bram_en_lab,alu_enable, pc_branch, imm_value_enable,imm_flw);
	
    DATAPATH datapath_module(instruction_code[19:15], instruction_code[24:20], instruction_code[11:7], alu_control, regwrite, clock, reset,ar,imm,bram_en_mem,!bram_en_mem,alu_enable, is_greater_than,imm_value_enable, cnt, imm_flw);

    always @(posedge clock) 
    begin
        $display("PROCESSOR: cnt: %b, instruction_code = %h, imm_value_enable = %b",cnt, instruction_code, imm_value_enable);
    end
endmodule