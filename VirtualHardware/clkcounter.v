module clkcounter(cp, q)
    input wire cp,
    output q;

    reg [7:0] count;
    
    always @(negedge cp) begin
        count <= count + 1;
        if (count[7:5] == 3'b111 && count[2] == 1'b1)
            count <= 8'b00000000;
        q <= (count[7] || count[6] || count [5] || count[4]);
    end

endmodule