module preparcial_ej2_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic E1, E0;
  logic S1, S0, V;
  preparcial_ej2 dut (
    .E1(E1), .E0(E0), .S1(S1), .S0(S0), .V(V)
  );

  `include "tb_helpers.svh"

  task automatic check_case(
    input logic e1, e0,
    input logic expected_v,
    input logic check_s,
    input logic expected_s1, expected_s0,
    input string label
  );
    begin
      E1 = e1;
      E0 = e0;
      #1;
      expect_eq($sformatf("%s V", label), {31'b0, V},
                {31'b0, expected_v});
      if (check_s)
        expect_eq($sformatf("%s S1S0", label), {30'b0, S1, S0},
                  {30'b0, expected_s1, expected_s0});
    end
  endtask

  initial begin
    nfail = 0;
    done = 1'b0;
    pass_all = 1'b0;
    E1 = 1'b0;
    E0 = 1'b0;
    wait (!rst);

    // CA1: 00(+0)+1 = 01(+1).
    check_case(1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b1, "E=00");
    // CA1: 01(+1)+1 = +2, fuera de rango con dos bits.
    check_case(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, "E=01");
    // CA1: 10(-1)+1 = cero; se aceptan sus dos códigos, 00 y 11.
    E1 = 1'b1;
    E0 = 1'b0;
    #1;
    expect_eq("E=10 V", {31'b0, V}, 32'b0);
    if (!((S1 == 1'b0 && S0 == 1'b0) || (S1 == 1'b1 && S0 == 1'b1))) begin
      $display("FAIL E=10 S1S0: se esperaba 00 o 11, se obtuvo %b%b", S1, S0);
      nfail++;
    end
    // CA1: 11(-0)+1 = 01(+1).
    check_case(1'b1, 1'b1, 1'b0, 1'b1, 1'b0, 1'b1, "E=11");

    finish_tb();
  end
endmodule
