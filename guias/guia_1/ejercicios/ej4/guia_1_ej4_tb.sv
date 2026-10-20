module guia_1_ej4_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic a, b, c;
  logic out;
  logic f_sop, f_pos, g_sop, g_pos;
  logic f_pos_simplificada, g_sop_simplificada;
  // Bit i = salida para la entrada abc=i, según las tablas del enunciado.
  localparam logic [7:0] TABLA_F = 8'b10111000;
  localparam logic [7:0] TABLA_G = 8'b11011011;
  integer i;

  funcion3 dut (.a(a), .b(b), .c(c), .out(out));
  guia1_ej4 formas (
    .a(a), .b(b), .c(c),
    .f_sop(f_sop), .f_pos(f_pos), .g_sop(g_sop), .g_pos(g_pos),
    .f_pos_simplificada(f_pos_simplificada),
    .g_sop_simplificada(g_sop_simplificada)
  );

  `include "tb_helpers.svh"

  initial begin
    nfail = 0;
    done = 1'b0;
    pass_all = 1'b0;
    {a, b, c} = 3'b000;
    wait (!rst);

    $display("a b c | F G | funcion3");
    for (i = 0; i < 8; i++) begin
      {a, b, c} = i[2:0];
      #1;
      $display("%b %b %b | %b %b | %b", a, b, c, f_sop, g_sop, out);
      // La consigna pide detener la simulación ante una salida incorrecta.
      if (out !== TABLA_F[i])
        $fatal(1, "funcion3 abc=%b: salida=%b, esperada=%b",
               {a, b, c}, out, TABLA_F[i]);
      expect_eq($sformatf("formas de F abc=%b", {a, b, c}),
                {29'b0, f_sop, f_pos, f_pos_simplificada},
                {29'b0, {3{TABLA_F[i]}}});
      expect_eq($sformatf("formas de G abc=%b", {a, b, c}),
                {29'b0, g_sop, g_pos, g_sop_simplificada},
                {29'b0, {3{TABLA_G[i]}}});
    end

    finish_tb();
  end
endmodule
