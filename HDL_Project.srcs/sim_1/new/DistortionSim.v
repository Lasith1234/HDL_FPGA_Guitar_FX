`timescale 1ns / 1ps

module DistortionSim;

  reg clk;
  reg rst;
  reg [15:0] guitar_input;
  reg [3:0] gain;
  wire [15:0] distorted_output;

  DistortionEffect uut (
    .clk(clk),
    .rst(rst),
    .guitar_input(guitar_input),
    .gain(gain),
    .distorted_output(distorted_output)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    
    gain = 4'd2;
    guitar_input = 16'h0000; #10
    
    guitar_input = 16'h1000; #10; 

    guitar_input = 16'h2000; #10 
    
    guitar_input = 16'h3000; #10 
    
    guitar_input = 16'h4000; #10 
    
    guitar_input = 16'h5000; #10 
    
    // ---------------------------------------------
   
    gain = 4'd3;
    guitar_input = 16'h0000; #10
    
    guitar_input = 16'h1000; #10 

    guitar_input = 16'h2000; #10 
    
    guitar_input = 16'h3000; #10 
    
    guitar_input = 16'h4000; #10 
    
    guitar_input = 16'h5000; #10 
    
    #10 $finish;
  end

endmodule
