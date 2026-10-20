module decoder2a4  (
    input  logic [1:0] in,
    output logic [3:0] out
);

    assign out[0] = ~in[1] & ~in[0];
    assign out[1] = ~in[1] &  in[0];
    assign out[2] = in[1] & ~in[0];
    assign out[3] = in[1] &  in[0];

endmodule

module demux1a4_jerarquico (
    input  logic       data,
    input  logic [1:0] sel,
    output logic [3:0] out
);

    logic [3:0] decoder_out;

    decoder2a4 decoder (
        .in(sel),
        .out(decoder_out)
    );

    assign out[0] = data & decoder_out[0];
    assign out[1] = data & decoder_out[1];
    assign out[2] = data & decoder_out[2];
    assign out[3] = data & decoder_out[3];

endmodule

module demux1a4_plano (
    input  logic       data,
    input  logic [1:0] sel,
    output logic [3:0] out
);

    assign out[0] = data & ~sel[1] & ~sel[0];
    assign out[1] = data & ~sel[1] &  sel[0];
    assign out[2] = data &  sel[1] & ~sel[0];
    assign out[3] = data &  sel[1] &  sel[0];

endmodule
