// Module row counter
// performs count of horizontal sync events during vertical sync
// vertical sync starts counter
// cp is wired to HSb
// mr is wired to FSb
// q is high on 24th HSync
module rowcounter(cp,mr,q);
    input wire cp,
    input wire mr,
    output reg q;

    reg [4:0] count;

    always @(negedge cp) begin
        count <= 1 + count;
        if (mr)
            count <= 5'b00000;
        q <= (count == 5'b11000);
        if (q)
            count <= 5'b00000;
    end
endmodule
