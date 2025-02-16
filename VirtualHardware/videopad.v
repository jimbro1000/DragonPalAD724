module design videopad(Format, HSb, FSb, VCLK, NHSb, CLK, LUMAC, LPulse)
    input wire Format, // video format
    input wire HSb, // horizontal sync
    input wire FSb, // vertical sync
    input wire VCLK, // raw video clock
    output reg NHSb, // modified horizontal sync
    output reg CLK, // modified clock
    output reg LUMAC, // luma control (PAL only)
    output reg LPulse; // synthetic sync pulse (PAL only)
    
    wire delay24;
    wire fsp;
    wire use_v;
    wire iclk;
    wire pulse;
    wire pulse25;
    wire lumacontrol;

    rowCounter RC(HSb, FSb, delay24);
    d_flipflop LC(!VCLK, fsp ^ pulse25, use_v, lumacontrol);
    clkcounter genpulse(iclk, pulse);
    pulsecounter lpcount(pulse, pulse25);

    iclk <= !(VCLK & lumacontrol);
    fsp <= !(!FSb & delay24);

    if (Format) begin //NTSC
        NHSb <= HSb;
        LUMAC <= 1'b0;
        LPulse <= 1'b0; // noise reduction
        CLK <= VCLK;
    end else begin //PAL
        NHSb <= pulse ^ HSb;
        LUMAC <= lumacontrol;
        LPulse <= !pulse;
        CLK <= !(VCLK & use_v);
    end
endmodule
