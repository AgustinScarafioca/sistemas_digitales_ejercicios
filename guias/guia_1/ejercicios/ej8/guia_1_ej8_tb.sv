module guia_1_ej8_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);


  localparam int N = 3;

  logic [N-1:0] in;
  logic         invert;
  logic [N-1:0] out;

  logic [N-1:0] esperado;

  integer i;

  inversor_controlado #(
      .N(N)
  ) dut (
      .in(in),
      .invert(invert),
      .out(out)
  );

  initial begin

      done = 1'b0;
      pass_all = 1'b0;

      in = '0;
      invert = 1'b0;

      wait (!rst);

      for (i = 0; i < 16; i++) begin

          {invert, in} = i[3:0];

          esperado = invert ? ~in : in;

          #1;

          $display(
              "invert=%b in=%b out=%b esperado=%b",
              invert, in, out, esperado
          );

          if (out !== esperado)
              $fatal(
                  1,
                  "Error invert=%b in=%b: out=%b esperado=%b",
                  invert, in, out, esperado
              );

      end

      pass_all = 1'b1;
      done = 1'b1;

  end

endmodule
