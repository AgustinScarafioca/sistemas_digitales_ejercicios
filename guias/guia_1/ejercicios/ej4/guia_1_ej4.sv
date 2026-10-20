// En funcion3, a, b, c corresponden a A, B, C de la función F.
module funcion3 (
  input  logic a,
  input  logic b,
  input  logic c,
  output logic out
);
  assign out = (a & ~b) | (b & c);
endmodule

// Las entradas a, b, c representan A,B,C para F y D,E,F para G.
// Se comparten entradas solo para comparar ambas tablas en la simulación.
module guia1_ej4 (
  input  logic a,
  input  logic b,
  input  logic c,
  output logic f_sop,
  output logic f_pos,
  output logic g_sop,
  output logic g_pos,
  output logic f_pos_simplificada,
  output logic g_sop_simplificada
);
  assign f_sop = (~a & b & c) | (a & ~b & ~c) | (a & ~b & c) | (a & b & c);
  assign f_pos = (a | b | c) & (a | b | ~c) & (a | ~b | c) & (~a | ~b | c);

  assign g_sop = (~a & ~b & ~c) | (~a & ~b & c) | (~a & b & c) | (a & ~b & ~c) | (a & b & ~c) | (a & b & c);
  assign g_pos = (a | ~b | c) & (~a | b | ~c);

  assign f_pos_simplificada = (a | b) & (~b | c);
  assign g_sop_simplificada = (~a & ~b) | (b & c) | (a & ~c);
endmodule
