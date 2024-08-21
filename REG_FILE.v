module REG_FILE(
    input [4:0] read_reg_num1,
    input [4:0] read_reg_num2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output[31:0] read_data1,
    output [31:0] read_data2,
    input regwrite,
    input clock,
    input reset
);

    reg [31:0] reg_memory [31:0];
     // 32 memory locations each 32 bits wide
    integer i=0;
    
    assign read_data1 = reg_memory[read_reg_num1];
    assign read_data2 = reg_memory[read_reg_num2];
    // If clock edge is positive and regwrite is 1, we write data to specified register
    always @(posedge clock)
    begin
        if(reset)
        begin
       // Bear with me for now, I tried using loops, but it won't work
        // Just duct-taping this for now
         reg_memory[0] = 32'h0;
         reg_memory[1] = 32'h0;
         reg_memory[2] = 32'h0;
         reg_memory[3] = 32'h0;
         reg_memory[4] = 32'h0;
         reg_memory[5] = 32'h0;
         reg_memory[6] = 32'h0;
         reg_memory[7] = 32'h0;
         reg_memory[8] = 32'h0;
         reg_memory[9] = 32'h0;
         reg_memory[10] = 32'h0;
         reg_memory[11] = 32'h0;
         reg_memory[12] = 32'h0;
         reg_memory[13] = 32'h0;
         reg_memory[14] = 32'h0;
         reg_memory[15] = 32'h0;
         reg_memory[16] = 32'h0;
         reg_memory[17] = 32'h0;
         reg_memory[18] = 32'h0;
         reg_memory[19] = 32'h0;
         reg_memory[20] = 32'h0;
         reg_memory[21] = 32'h0;
         reg_memory[22] = 32'h0;
         reg_memory[23] = 32'h0;
         reg_memory[24] = 32'h0;
         reg_memory[25] = 32'h0;
		 reg_memory[26] = 32'h0;
         reg_memory[27] = 32'h0;
         reg_memory[28] = 32'h0;
         reg_memory[29] = 32'h0;
         reg_memory[30] = 32'h0;
         reg_memory[31] = 32'h0;
        end
        else
        if (regwrite) 
            begin
                reg_memory[write_reg] <= write_data;
            end  
        for(i =0 ;i<32;i = i+1)
           begin
              $display("Reg File: Reg[%d] = %h.",i,reg_memory[i]);
           end 

        end 
        
endmodule
