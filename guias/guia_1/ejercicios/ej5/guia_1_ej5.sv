module demux1a4 (
    input  logic       data,
    input  logic [1:0] sel,
    output logic [3:0] out
);

    assign out[0] = data & ~sel[1] & ~sel[0];
    assign out[1] = data & ~sel[1] &  sel[0];
    assign out[2] = data &  sel[1] & ~sel[0];
    assign out[3] = data &  sel[1] &  sel[0];

endmodule
