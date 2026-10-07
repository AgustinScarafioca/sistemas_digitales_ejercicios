integer nfail;

task automatic expect_eq(
  input string tag,
  input logic [31:0] got,
  input logic [31:0] expected
);
  if (got !== expected) begin
    $display("FAIL: %s got=%0d (%b), expected=%0d (%b)",
             tag, got, got, expected, expected);
    nfail++;
  end
endtask

task automatic finish_tb();
  pass_all = (nfail == 0);
  done = 1'b1;
  if (pass_all)
    $display("Todos los casos pasaron.");
  else
    $display("fallos: %0d", nfail);
endtask
