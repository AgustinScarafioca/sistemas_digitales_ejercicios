module latch_d (
    input  logic D,
    input  logic enable,
    input  logic rst,
    output logic Q
);

    always_latch begin
        if (rst)
            Q = 1'b0;
        else if (enable)
            Q = D;
    end

endmodule

module flipflop_d (
    input  logic clk,
    input  logic D,
    input  logic rst,
    output logic Q
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule
