`timescale 1ns / 1ps

module DataBuffer (
    input wire clk,           
    input wire data_in,       
    output reg [11:0] buffer
);

reg [0:0] buffer_data; 
reg [3:0] buffer_ptr = 4'b0000; 

always @(posedge clk) begin
    buffer_data <= data_in;
    buffer[buffer_ptr] <= buffer_data; 
    
    if (buffer_ptr == 11) begin
        buffer_data <= 0;
        buffer_ptr <= 4'b0000;
    end else begin
        buffer_ptr <= buffer_ptr + 1;
    end
end
endmodule