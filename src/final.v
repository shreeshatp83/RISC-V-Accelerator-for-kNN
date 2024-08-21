module final #(parameter k = 1, parameter num_of_rows = 1)(
    input final_enable,
    input [3:0] lab,
    input [31:0] sqrt_value,
    input [3:0] alu_control,
    input [9:0] cnt,
    output reg [3:0] label
    );

    reg [3:0] labels[num_of_rows - 1:0];
    reg [31:0] sqrt_values[num_of_rows - 1:0];
    integer label_index;
    integer sqrt_index;
    integer i, j, min_index;
    reg [3:0] temp_label;
    reg [31:0] temp_value;
    reg [31:0] count[15:0]; // Count array for finding the most occurred number
    reg [3:0] most_occurred;
    reg [31:0] max_count;

    initial begin
        label_index = 0; // Initialize the label index counter
        sqrt_index = 0;  // Initialize the sqrt_values index counter
        label = 0;
    end
    
//    always @(cnt) begin
//    if(final_enable) 
//    if(alu_control== 4'b0100) begin
//    for(i=0;i<label_index;i=i+1) 
//    $display("sqrt_value[%d] : %h, label[%d]: %h ",i,sqrt_values[i],i,labels[i] );
//    end
//    if(alu_control== 4'b0011) begin
//    for(i=0;i<label_index;i=i+1) 
//    $display("sqrt_value[%d] : %h, label[%d]: %h ",i,sqrt_values[i],i,labels[i] );
//    end
//    if(alu_control== 4'b0101) begin
//    for(i=0;i<label_index;i=i+1) 
//    $display("sqrt_value[%d] : %h, label[%d]: %h ",i,sqrt_values[i],i,labels[i] );
//    end
//    end

    always @(*)
    begin
    if(final_enable)
    begin
        case (alu_control)
            4'b0011: begin
                if (label_index < num_of_rows) begin
                    // Store lab in labels array sequentially
                    labels[label_index] = lab;
                    label = 4'b1111; // Acknowledge
                    label_index = label_index + 1;          
                end
            end

            4'b0100: begin
                if (sqrt_index < num_of_rows) begin
                    // Store sqrt_value in sqrt_values array sequentially
                    sqrt_values[sqrt_index] = sqrt_value;
                    label = 4'b1110; // Acknowledge
                    sqrt_index = sqrt_index + 1;                   
                end
            end

            4'b0101: begin
                // Find the k smallest elements in sqrt_values and corresponding labels
                for (i = 0; i < k; i = i + 1) begin
                    min_index = i;
                    for (j = i + 1; j < num_of_rows; j = j + 1) begin
                        if (sqrt_values[j] < sqrt_values[min_index]) begin
                            min_index = j;
                        end
                    end
                    // Swap the found minimum element with the element at index i
                    temp_value = sqrt_values[i];
                    sqrt_values[i] = sqrt_values[min_index];
                    sqrt_values[min_index] = temp_value;

                    // Swap the corresponding labels
                    temp_label = labels[i];
                    labels[i] = labels[min_index];
                    labels[min_index] = temp_label;
                end
                // Find the most occurred number in the first k elements of labels array
                for (i = 0; i < 16; i = i + 1) begin
                    count[i] = 0;
                end

                for (i = 0; i < k; i = i + 1) begin
                    count[labels[i]] = count[labels[i]] + 1;
                end

                max_count = 0;
                most_occurred = 4'b0000;
                for (i = 0; i < 16; i = i + 1) begin
                    if (count[i] > max_count) begin
                        max_count = count[i];
                        most_occurred = i;
                    end
                end
                
                // Set the most occurred number to label
                label = most_occurred;
            end

        endcase
    end
    end

endmodule
