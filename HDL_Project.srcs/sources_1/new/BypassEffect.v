`timescale 1ns / 1ps

module BypassEffect(
    input wire guitar_input,
    output wire bypass_output
    );

  assign bypass_output = guitar_input;

endmodule




