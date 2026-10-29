// Ejercicio 2 del preparcial: completar el circuito según la consigna.
module preparcial_ej2 (
  input  logic E1,
  input  logic E0,
  output logic S1,
  output logic S0,
  output logic V
);
  
  logic not_e0;
  assign not_e0 = ~E0;
  assign S0 = not_e0;
  assign S1 = E1 | not_e0;
  assign V = E1 & S0;
  
endmodule
