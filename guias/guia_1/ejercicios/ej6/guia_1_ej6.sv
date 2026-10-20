module encoder4 (
    input  logic [3:0] in,
    output logic [1:0] code,
    output logic       valid
);

    always_comb begin

        code  = 2'b00;
        valid = 1'b0;

        case (in)

            4'b0001: begin
                // solo valid porque code pasa con 00
                valid = 1'b1;
            end

            4'b0010: begin
                code = 2'b01;
                valid = 1'b1;
            end

            4'b0100: begin
                code = 2'b10;
                valid = 1'b1;
            end

            4'b1000: begin
                code = 2'b11;
                valid = 1'b1;
            end

            default: begin
                code = 2'b00;
                valid = 1'b0;
            end

        endcase

    end

endmodule
