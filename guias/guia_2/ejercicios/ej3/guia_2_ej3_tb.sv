module guia_2_ej3_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);

  logic D;
  logic Q_latch;
  logic Q_ff;
  integer nfail;

  latch_d latch_inst (
      .D(D),
      .enable(clk),
      .rst(rst),
      .Q(Q_latch)
  );

  flipflop_d ff_inst (
      .clk(clk),
      .D(D),
      .rst(rst),
      .Q(Q_ff)
  );

  task automatic check_values(
      input string label,
      input logic expected_latch,
      input logic expected_ff
  );
    begin
      $display("%s: clk=%b D=%b Q_latch=%b Q_ff=%b",
               label, clk, D, Q_latch, Q_ff);
      if (Q_latch !== expected_latch) begin
        $error("%s: Q_latch=%b, esperado=%b",
               label, Q_latch, expected_latch);
        nfail++;
      end
      if (Q_ff !== expected_ff) begin
        $error("%s: Q_ff=%b, esperado=%b",
               label, Q_ff, expected_ff);
        nfail++;
      end
    end
  endtask

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    D = 1'b0;
    nfail = 0;

    // El runner mantiene rst activo durante los flancos iniciales. Empezamos
    // el cronograma en el primer flanco descendente posterior al reset.
    wait (!rst);
    @(negedge clk);

    #1;
    check_values("t=0 ns", 1'b0, 1'b0);

    // t=5 ns: flanco ascendente con D=0.
    #4;
    #1;
    check_values("t=5 ns, flanco ascendente", 1'b0, 1'b0);

    // t=7 ns: D cambia mientras el latch está transparente.
    #1;
    D = 1'b1;
    #1;
    check_values("t=7 ns, D cambia a 1", 1'b1, 1'b0);

    // t=10 ns: el latch cierra y conserva 1.
    #2;
    #1;
    check_values("t=10 ns, flanco descendente", 1'b1, 1'b0);

    // t=12 ns: D cambia con clk=0, por lo que el latch conserva su estado.
    #1;
    D = 1'b0;
    #1;
    check_values("t=12 ns, D cambia a 0", 1'b1, 1'b0);

    // t=15 ns: ambos elementos observan D=0 en el flanco ascendente.
    #2;
    #1;
    check_values("t=15 ns, flanco ascendente", 1'b0, 1'b0);

    // t=17 ns: latch transparente; el flip-flop conserva lo capturado.
    #1;
    D = 1'b1;
    #1;
    check_values("t=17 ns, D cambia a 1", 1'b1, 1'b0);

    // t=20 ns: el latch vuelve a cerrar.
    #2;
    #1;
    check_values("t=20 ns, flanco descendente", 1'b1, 1'b0);

    if (nfail != 0)
      $fatal(1, "Fallaron %0d verificaciones", nfail);

    pass_all = 1'b1;
    done = 1'b1;
  end

endmodule

