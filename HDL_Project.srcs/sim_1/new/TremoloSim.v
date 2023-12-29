`timescale 1ns / 1ps

module TremoloSim;

  reg clk;
  reg rst;
  reg [15:0] guitar_input;
  reg [15:0] rate;
  wire [15:0] tremolo_output;

  TremoloEffect uut (
    .clk(clk),
    .rst(rst),
    .guitar_input(guitar_input),
    .rate(rate),
    .tremolo_output(tremolo_output)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;

    rate = 16'd4;

    guitar_input = 16'd3000; #200
    guitar_input = 16'd10000; #200; 
    
    #10 $finish;
  end

endmodule

