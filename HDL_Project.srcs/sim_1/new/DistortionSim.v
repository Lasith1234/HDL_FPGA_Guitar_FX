`timescale 1ns / 1ps

module DistortionSim;

  reg clk;
  reg rst;
  reg [15:0] guitar_input;
  wire [15:0] distorted_output;

  DistortionEffect uut (
    .clk(clk),
    .rst(rst),
    .guitar_input(guitar_input),
    .distorted_output(distorted_output)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    //rst = 1;
    //#10 rst = 0;
    
    guitar_input = 16'h0000;
    
    #10 guitar_input = 16'h4000; 
    #100; 

    #10 guitar_input = 16'h6000; 
    #100;
    
    #10 guitar_input = 16'd50000; 
    #100;
    
    #10 $finish;
  end

endmodule
