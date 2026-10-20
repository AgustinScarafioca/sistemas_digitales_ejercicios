module guia_1_ej3_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic a, b, c;
  logic f, g, h;
  logic f_simplificada, g_demorgan, h_simplificada;
  logic [2:0] expected;
  integer i;

  guia1_ej3 dut (
    .a(a), .b(b), .c(c), .f(f), .g(g), .h(h),
    .f_simplificada(f_simplificada),
    .g_demorgan(g_demorgan),
    .h_simplificada(h_simplificada)
  );

  `include "tb_helpers.svh"

  initial begin
    nfail = 0;
    done = 1'b0;
    pass_all = 1'b0;
    {a, b, c} = 3'b000;
    wait (!rst);

    $display("a b c | f g h | f_simplificada g_demorgan h_simplificada");
    for (i = 0; i < 8; i++) begin
      {a, b, c} = i[2:0];
      // Tabla de verdad independiente de las expresiones del diseño.
      case (i)
        0: expected = 3'b010;
        1: expected = 3'b010;
        2: expected = 3'b010;
        3: expected = 3'b100;
        4: expected = 3'b100;
        5: expected = 3'b101;
        6: expected = 3'b100;
        7: expected = 3'b101;
        default: expected = 3'b000;
      endcase
      #1;

      $display("%b %b %b | %b %b %b | %b %b %b",
               a, b, c, f, g, h,
               f_simplificada, g_demorgan, h_simplificada);
      expect_eq($sformatf("originales abc=%b", {a, b, c}),
                {29'b0, f, g, h}, {29'b0, expected});
      expect_eq($sformatf("simplificadas abc=%b", {a, b, c}),
                {29'b0, f_simplificada, g_demorgan, h_simplificada},
                {29'b0, expected});
    end

    finish_tb();
  end
endmodule
