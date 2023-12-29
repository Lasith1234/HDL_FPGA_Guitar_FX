`timescale 1ns / 1ps

module TremoloEffect (
  input wire clk,
  input wire rst,
  input wire [15:0] guitar_input,
  input wire [15:0] rate,
  output wire [15:0] tremolo_output
);

  reg [15:0] tremolo_output_reg;
  reg [15:0] tremolo_counter;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      tremolo_output_reg <= 0;
      tremolo_counter <= 0;
    end else begin
      
      tremolo_output_reg <= (guitar_input >> tremolo_counter);
      tremolo_counter <= tremolo_counter + 1;
      
      if (tremolo_counter >= rate) begin
        tremolo_counter <= 0;
      end
      
    end
  end
  assign tremolo_output = tremolo_output_reg;

endmodule






