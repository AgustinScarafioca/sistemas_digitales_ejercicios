module guia_3_ej11_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic [7:0] x, y, sum;
  logic carry_sin_signo, overflow_signado;
  logic [15:0] x_extended_sin_signo, x_extended_signado;
  integer nfail;

  guia_3_ej11 dut (.*);

  task automatic check_case(
    input logic [7:0] a, b,
    input logic [7:0] expected_sum,
    input logic expected_carry,
    input logic expected_overflow,
    input logic [15:0] expected_zero_ext,
    input logic [15:0] expected_sign_ext
  );
    begin
      x = a; y = b; #1;
      if ({sum, carry_sin_signo, overflow_signado,
           x_extended_sin_signo, x_extended_signado} !==
          {expected_sum, expected_carry, expected_overflow,
           expected_zero_ext, expected_sign_ext}) begin
        $error("x=%02h y=%02h: resultados inesperados", x, y);
        nfail++;
      end
    end
  endtask

  initial begin
    done = 1'b0; pass_all = 1'b0; nfail = 0;
    x = '0; y = '0;
    wait (!rst);
    // TODO: agregar los casos hexadecimales indicados por la consigna,
    // incluyendo carry, overflow, operandos negativos y extensiones.
    $display("TODO: completar los casos autocontrolados del ejercicio 11");
    $fatal(1, "Testbench incompleto: agregue y ejecute los casos de prueba");
    if (nfail != 0) $fatal(1, "Fallaron %0d verificaciones", nfail);
    pass_all = 1'b1; done = 1'b1;
  end
endmodule
