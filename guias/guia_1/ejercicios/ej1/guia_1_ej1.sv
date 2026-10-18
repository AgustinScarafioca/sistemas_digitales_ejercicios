// Ejercicio 1 de la Guía 1.
// Implementar ambos lados de cada igualdad en las posiciones indicadas.
module guia1_ej1 (
  input  logic       x,
  input  logic       y,
  input  logic       z,
  output logic [4:0] lhs,
  output logic [4:0] rhs
);
  // Punto 1
  // x = x*y + x*~y
  assign lhs[0] = x;
  assign rhs[0] = (x & y) | (x & ~y);

  // Punto 2
  // (x+y)*(x+~y) = x
  assign lhs[1] = (x | y) & (x | ~y);
  assign rhs[1] = x;

  // Punto 3
  // x*z = (x+y)*(x+~y)*(~x+z)
  assign lhs[2] = x & z;
  assign rhs[2] = (x | y) & (x | ~y) & (~x | z);

  // Punto 4
  // ~(x+y*z) = ~x*(~y+~z)
  assign lhs[3] = ~(x | (y & z));
  assign rhs[3] = ~x & (~y | ~z);

  // Punto 5 
  // x^(y*z) = (x^y)*(x^z)
  assign lhs[4] = x ^ (y & z);
  assign rhs[4] = (x ^ y) & (x ^ z);

endmodule
