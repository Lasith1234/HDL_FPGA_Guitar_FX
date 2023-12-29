`timescale 1ns / 1ps

module TremoloEffect (
  input wire clk,
  input wire rst,
  input wire [15:0] guitar_input,
  output wire [15:0] tremolo_output
);
  parameter DEPTH = 4'd4; 
  parameter RATE = 16'b0000000000001010; 

  reg [15:0] tremolo_output_reg;
  reg [15:0] tremolo_depth_reg;
  reg [15:0] tremolo_rate_counter;
  
  wire [15:0] temp;
  assign temp = tremolo_depth_reg;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      tremolo_output_reg <= 0;
      tremolo_depth_reg <= 0;
      tremolo_rate_counter <= 0;
    end else begin
      tremolo_depth_reg <= tremolo_depth_reg + DEPTH;
      if (tremolo_depth_reg >= 16'd16) tremolo_depth_reg <= 0;

      //tremolo_rate_counter <= tremolo_rate_counter + 1;
      //if (tremolo_rate_counter == RATE) tremolo_rate_counter <= 0;

      tremolo_output_reg <= guitar_input + tremolo_depth_reg;
      //tremolo_output_reg <= guitar_input;
    end
  end
  assign tremolo_output = tremolo_output_reg;

endmodule






