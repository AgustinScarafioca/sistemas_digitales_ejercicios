// Ejercicio 1 de la Guía 1.
// Implementar ambos lados de cada igualdad en las posiciones indicadas.
module guia1_ej1 (
  input  logic       x,
  input  logic       y,
  input  logic       z,
  output logic [4:0] lhs,
  output logic [4:0] rhs
);
  // lhs[0] = x                         rhs[0] = x*y + x*~y
  // lhs[1] = (x+y)*(x+~y)              rhs[1] = x
  // lhs[2] = x*z                       rhs[2] = (x+y)*(x+~y)*(~x+z)
  // lhs[3] = ~(x+y*z)                  rhs[3] = ~x*(~y+~z)
  // lhs[4] = x^(y*z)                   rhs[4] = (x^y)*(x^z)

  // TODO: reemplazar estos valores temporales por las cinco expresiones.
  always_comb begin
    lhs = '0;
    rhs = '0;
  end
endmodule
