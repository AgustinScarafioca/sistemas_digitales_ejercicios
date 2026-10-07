`ifndef TB_MODULE
`define TB_MODULE missing_tb
`endif

module sim_top;
  logic clk = 1'b0;
  logic rst;
  logic done;
  logic pass_all;

  always #5 clk = ~clk;

  initial begin
    string trace_file;
    if (!$value$plusargs("trace_file=%s", trace_file))
      trace_file = "obj_dir/sim.vcd";
    $dumpfile(trace_file);
    $dumpvars(0, sim_top);
    rst = 1'b1;
    repeat (2) @(posedge clk);
    rst = 1'b0;
    wait (done);
    repeat (1) @(posedge clk);
    if (!pass_all) $fatal(1, "Uno o más casos de prueba fallaron");
    $finish;
  end

  `TB_MODULE tb (.clk(clk), .rst(rst), .done(done), .pass_all(pass_all));
endmodule
