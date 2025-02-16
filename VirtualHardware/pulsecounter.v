// Module line pulse counter
// performs divide by 50 count of line pulses
// cp is wired to line pulse
// q is high on 25th pulse for 25 pulses
// implemented in original hardware using a LS390
module pulsecounter(cp,q);
    input wire cp,
    output reg q;

    reg [5:0] count;
    reg over25;

    always @(negedge cp) begin
        count <= 1 + count;
        if (count == 6'b110010) begin
            count <= 6'b00000;
            over25 <= 0;
        end
        if (count == 6'b011001)
            over25 <= 1;
        q <= over25;
    end
endmodule
