`timescale 1ns / 1ps

module TremoloSim;

  reg clk;
  reg rst;
  reg [15:0] guitar_input;
  wire [15:0] tremolo_output;

  TremoloEffect uut (
    .clk(clk),
    .rst(rst),
    .guitar_input(guitar_input),
    .tremolo_output(tremolo_output)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;

    guitar_input = 16'h4000; 

    #10 guitar_input = 16'h5000;
    #100; 
    
    #10 guitar_input = 16'h1000;
    #100; 
    
    #1000 $finish;
  end

endmodule

