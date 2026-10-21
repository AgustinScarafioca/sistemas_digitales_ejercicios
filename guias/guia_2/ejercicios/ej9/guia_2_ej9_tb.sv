module guia_2_ej9_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    wait (!rst);
    $fatal(1, "TODO: implementar diseño y verificaciones del ejercicio 9");
  end
endmodule

