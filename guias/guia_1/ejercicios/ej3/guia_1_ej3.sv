// Ejercicio 3: funciones originales y sus simplificaciones.
module guia1_ej3 (
  input  logic a,
  input  logic b,
  input  logic c,
  output logic f,
  output logic g,
  output logic h,
  output logic f_simplificada,
  output logic g_demorgan,
  output logic h_simplificada
);
  assign f = (a & b) | (a & ~b) | (~a & b & c);
  assign g = ~(a | (b & c));
  assign h = (a | b) & (a | ~b) & (~a | c);

  assign f_simplificada = a | (b & c);
  assign g_demorgan = ~a & (~b | ~c);
  assign h_simplificada = a & c;
endmodule
