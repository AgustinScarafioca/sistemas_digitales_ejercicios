module registro_extensor (
    input  logic       clk,
    input  logic       load,
    input  logic       ext,
    input  logic [3:0] data_in,
    output logic [3:0] out
);

    logic [3:0] registro;

    always_ff @(posedge clk) begin
        if (load)
            registro <= data_in;
    end

    always_comb begin
        if (ext)
            out = {{2{registro[1]}}, registro[1:0]};
        else
            out = registro;
    end

endmodule
