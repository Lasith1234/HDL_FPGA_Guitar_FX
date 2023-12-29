`timescale 1ns / 1ps

module DistortionEffect (
  input wire clk,
  input wire rst,
  input wire [15:0] guitar_input,
  output wire [15:0] distorted_output
);

  parameter GAIN = 4'b1000; 

  reg [15:0] distorted_output_reg;

  always @(posedge clk or posedge rst) begin
    
    if (rst) begin
      distorted_output_reg <= 0;
    end 
    else begin
      if (guitar_input > 16'h7FFF) begin
        distorted_output_reg <= 16'h7FFF;  
      end 
      else begin
        distorted_output_reg <= guitar_input;
      end
    end
    
  end
  assign distorted_output = distorted_output_reg;

endmodule



