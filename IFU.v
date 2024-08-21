`include "bram_inst.v"

module IFU(
    input clock,reset,
    input pc_branch,
    input is_greater_than,
    input [11:0] imm,
    output [31:0] Instruction_Code,
    output [9:0] cnt
);
reg [31:0] PC = 32'b0;  // 32-bit program counter is initialized to zero
reg [9:0] cnt = 10'b0;
    // Initializing the instruction memory block
    bram_inst instr_mem(clock,1,PC,Instruction_Code);

    always @(posedge clock, posedge reset)
    begin
        if(reset == 1) 
        begin //If reset is one, clear the program counter
            PC <= 0;
            cnt<=0;
        end
        else
        begin
            cnt = cnt+1;
            if(pc_branch && is_greater_than)
                PC <= PC - imm;
            else
                PC <= PC+4;
         end   // Increment program counter on positive clock edge
    end

endmodule
