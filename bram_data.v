module bram_data(  
    input clock,
	input ram_enable,
    input [7:0]	PC,
	output [31:0] data
);

  // (* RAM_STYLE="BLOCK" *)
   reg [31:0] Memory [0:511];
   
   initial 
   begin
       $readmemb("data_file.mem", Memory);
   end
   
   assign data = ram_enable==1 ?{Memory[PC]}:data;

endmodule