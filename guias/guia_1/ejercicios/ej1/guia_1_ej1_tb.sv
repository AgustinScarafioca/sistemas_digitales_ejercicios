module guia_1_ej1_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic x, y, z;
  logic [4:0] lhs, rhs;
  logic [4:0] expected_lhs, expected_rhs;
  logic [2:0] input_bits;
  integer i;

  guia1_ej1 dut (.x(x), .y(y), .z(z), .lhs(lhs), .rhs(rhs));

  `include "tb_helpers.svh"

  initial begin
    nfail = 0;
    done = 1'b0;
    pass_all = 1'b0;
    x = 1'b0;
    y = 1'b0;
    z = 1'b0;
    wait (!rst);

    for (i = 0; i < 8; i++) begin
      input_bits = i[2:0];
      {x, y, z} = input_bits;
      #1;

      expected_lhs[0] = x;
      expected_lhs[1] = (x | y) & (x | ~y);
      expected_lhs[2] = x & z;
      expected_lhs[3] = ~(x | (y & z));
      expected_lhs[4] = x ^ (y & z);

      expected_rhs[0] = (x & y) | (x & ~y);
      expected_rhs[1] = x;
      expected_rhs[2] = (x | y) & (x | ~y) & (~x | z);
      expected_rhs[3] = ~x & (~y | ~z);
      expected_rhs[4] = (x ^ y) & (x ^ z);

      expect_eq($sformatf("lados izquierdos xyz=%b", input_bits),
                {27'b0, lhs}, {27'b0, expected_lhs});
      expect_eq($sformatf("lados derechos xyz=%b", input_bits),
                {27'b0, rhs}, {27'b0, expected_rhs});
    end

    finish_tb();
  end
endmodule
