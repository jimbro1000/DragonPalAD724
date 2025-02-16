// Simplified D-Type flip-flop without set or reset
module d_flipflop (
    input wire clk,    // Clock input
    input wire d,      // Data input
    output reg q       // Output
    output reg qb      // Inverted Output
);

always @(posedge clk) begin
    q <= d;        // Assign data input to output on clock edge
    qb <= !q;
end

endmodule