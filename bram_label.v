module bram_label(  
    input clock,
	input ram_enable,
    input [7:0]	PC,
	output reg [31:0] label
);

  // (* RAM_STYLE="BLOCK" *)
   reg [31:0] Memory [0:511];
   
   initial begin
       $readmemb("label.mem", Memory);
      end

   always @(posedge clock)
      if (ram_enable) 
      begin
            label = Memory[PC];
            $display("bram_data_label: PC = %d, data = %h", PC, label);
      end

endmodule