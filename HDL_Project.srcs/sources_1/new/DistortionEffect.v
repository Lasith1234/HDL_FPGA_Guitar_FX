`timescale 1ns / 1ps

module DistortionEffect (
  input wire clk,
  input wire rst,
  input wire [15:0] guitar_input,
  input wire [3:0] gain,
  output wire [15:0] distorted_output
);

  wire[23:0] post_gain_input;
  assign post_gain_input = gain * guitar_input;
  reg [15:0] distorted_output_reg;

  always @(posedge clk or posedge rst) begin
    
    if (rst) begin
      distorted_output_reg <= 0;
    end 
    else begin
      if (post_gain_input > 24'h7FFF) begin
        distorted_output_reg <= 16'h7FFF;  
      end 
      else begin
        distorted_output_reg <= post_gain_input[15:0];
      end
    end
    
  end
  assign distorted_output = distorted_output_reg;

endmodule



