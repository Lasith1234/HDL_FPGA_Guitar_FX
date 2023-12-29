`timescale 1ns / 1ps

module ReverbEffect (
  input wire clk,
  input wire rst,
  input wire [15:0] audio_input,
  output wire [15:0] audio_output
);

  parameter DELAY_1 = 1500;
  parameter DELAY_2 = 2000;
  parameter DELAY_3 = 2500;
  parameter DELAY_4 = 3000;
  parameter FEEDBACK_COEFF = 8'b01111111; 

  reg [15:0] delay_line_1 [0:DELAY_1-1];
  reg [15:0] delay_line_2 [0:DELAY_2-1];
  reg [15:0] delay_line_3 [0:DELAY_3-1];
  reg [15:0] delay_line_4 [0:DELAY_4-1];
  reg [15:0] feedback_1, feedback_2, feedback_3, feedback_4;


  reg [15:0] audio_output_reg;
  reg [15:0] i;

    always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (i = 0; i < DELAY_1; i = i + 1) delay_line_1[i] <= 0;
      for (i = 0; i < DELAY_2; i = i + 1) delay_line_2[i] <= 0;
      for (i = 0; i < DELAY_3; i = i + 1) delay_line_3[i] <= 0;
      for (i = 0; i < DELAY_4; i = i + 1) delay_line_4[i] <= 0;
      
      feedback_1 <= 0;
      feedback_2 <= 0;
      feedback_3 <= 0;
      feedback_4 <= 0;
      audio_output_reg <= 0;
    end else begin
  
      feedback_1 <= delay_line_1[DELAY_1-1];
      feedback_2 <= delay_line_2[DELAY_2-1];
      feedback_3 <= delay_line_3[DELAY_3-1];
      feedback_4 <= delay_line_4[DELAY_4-1];

      for (i = DELAY_1-1; i > 0; i = i - 1) delay_line_1[i] <= delay_line_1[i-1];
      for (i = DELAY_2-1; i > 0; i = i - 1) delay_line_2[i] <= delay_line_2[i-1];
      for (i = DELAY_3-1; i > 0; i = i - 1) delay_line_3[i] <= delay_line_3[i-1];
      for (i = DELAY_4-1; i > 0; i = i - 1) delay_line_4[i] <= delay_line_4[i-1];

      delay_line_1[0] <= audio_input + (feedback_4 >> 1);
      delay_line_2[0] <= audio_input + (feedback_1 >> 1);
      delay_line_3[0] <= audio_input + (feedback_2 >> 1);
      delay_line_4[0] <= audio_input + (feedback_3 >> 1);

      audio_output_reg <= (audio_input >> 1) + (feedback_1 >> 2) + (feedback_2 >> 2) + (feedback_3 >> 2) + (feedback_4 >> 2);

      feedback_1 <= (feedback_1 * FEEDBACK_COEFF) >> 7;
      feedback_2 <= (feedback_2 * FEEDBACK_COEFF) >> 7;
      feedback_3 <= (feedback_3 * FEEDBACK_COEFF) >> 7;
      feedback_4 <= (feedback_4 * FEEDBACK_COEFF) >> 7;
    end
  end
  assign audio_output = audio_output_reg;

endmodule


