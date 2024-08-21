module bram_inst(  
    input	clock,
	input	ram_enable,
    input 	[31:0]	PC,
	output 	[31:0] 	data
);

  // (* RAM_STYLE="BLOCK" *)
   reg [7:0] Memory [0:511];
   
   initial 
      begin
       $readmemh("inst.mem", Memory);
      end
      
    assign data = {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};
endmodule