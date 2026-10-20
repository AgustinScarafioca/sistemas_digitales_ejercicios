module guia_1_ej6_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
    logic [3:0] in;
    logic [1:0] code;
    logic       valid;

    logic [1:0] code_esperado;
    logic       valid_esperado;

    integer i;

    encoder4 dut (
    .in(in),
    .code(code),
    .valid(valid)
    );

    initial begin
        done = 1'b0;
        pass_all = 1'b0;

        in = 4'b0000;

        wait (!rst);

        for (i = 0; i < 16; i++) begin
            valid_esperado = 1'b0;
            code_esperado = 2'b00;

            in = i[3:0];

            case(in)
                4'b0001: begin
                    valid_esperado = 1'b1;
                    code_esperado = 2'b00;
                end
                4'b0010: begin
                    valid_esperado = 1'b1;
                    code_esperado = 2'b01;
                end
                4'b0100: begin
                    valid_esperado = 1'b1;
                    code_esperado = 2'b10;
                end
                4'b1000:begin
                    valid_esperado = 1'b1;
                    code_esperado= 2'b11;
                end
                default: begin
                    valid_esperado = 1'b0;
                    code_esperado = 2'b00;
                end
            endcase
        #1;
        $display(
            "in=%b valid=%b esperado_valid=%b code=%b esperado_code=%b",
            in,
            valid,
            valid_esperado,
            code,
            code_esperado
        );

      // valid SIEMPRE debe coincidir
        if (valid !== valid_esperado)
            $fatal(
            1,
            "encoder4 in=%b: valid=%b, esperado=%b",
            in,
            valid,
            valid_esperado
        );

      // code solo importa cuando la entrada es válida
        if (valid_esperado && code !== code_esperado)
            $fatal(
            1,
            "encoder4 in=%b: code=%b, esperado=%b",
            in,
            code,
            code_esperado
        );

        end

        pass_all = 1'b1;
        done = 1'b1;
    end
endmodule
