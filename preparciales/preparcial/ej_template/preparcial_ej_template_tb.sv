module preparcial_ej_template_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    wait (!rst);
    $fatal(1, "TODO: agregar pruebas para el ejercicio del preparcial");
  end
endmodule
