module delay_module (
    input wire clk,       // Clock input
    input wire rst,       // Reset input
    input wire in_signal, // Input signal
    output wire out_signal // Output signal with delay
);

reg [7:0] delay_counter = 8'b00000000; // Delay counter with 8-bit width
reg delayed_out_signal; // Register to hold the delayed signal

always @(posedge clk or posedge rst) begin
    if (rst) begin
        delay_counter <= 8'b00000000; // Reset the delay counter
        delayed_out_signal <= 1'b0;   // Reset the delayed output signal
    end else begin
        delay_counter <= delay_counter + 1'b1;

        // When the delay counter reaches a desired value, set the delayed output signal
        if (delay_counter == 8'b11111111) begin
            delayed_out_signal <= in_signal;
        end else begin
            delayed_out_signal <= delayed_out_signal; // Keep the output signal the same
        end
    end
end

assign out_signal = delayed_out_signal;

endmodule


module DelayEffect (
    input wire clk,          // Clock signal
    input wire reset,        // Reset signal
    input wire [15:0] in,    // Input signal (16-bit for example)
    output wire [15:0] out   // Output signal (16-bit for example)
);

parameter DELAY_LENGTH = 1000; // Set the delay length in clock cycles
parameter FEEDBACK = 12'b0100; // Feedback strength (adjust as needed)

reg [15:0] delay_line [0:DELAY_LENGTH-1];
reg [11:0] delay_ptr;
reg [15:0] feedback;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        delay_ptr <= 0;
        delay_line <= 0;
        feedback <= 0;
    end else begin
        delay_ptr <= (delay_ptr + 1) % DELAY_LENGTH;
        feedback <= delay_line[delay_ptr] >> 4; // Adjust feedback scaling
        delay_line[delay_ptr] <= (in + feedback) >> 1; // Feedback and input averaging
    end
end

assign out = delay_line[delay_ptr];

endmodule
