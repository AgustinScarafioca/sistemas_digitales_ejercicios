module guia_2_ej10_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic s0, s1, s2, s3;
  logic reset_local;
  logic [3:0] luces;
  controlador_semaforo dut (
    .clk(clk), .reset(reset_local), .s0(s0), .s1(s1), .s2(s2), .s3(s3)
  );

  assign luces = {s0, s1, s2, s3};

  task automatic check_luces(input logic [3:0] esperado, input string contexto);
    if (luces !== esperado)
      $fatal(1, "%s: esperado luces=%b, recibido=%b", contexto, esperado, luces);
  endtask

  // La comparación del próximo valor permite rotar exactamente cada 100 flancos.
  task automatic avanzar_un_periodo(input logic [3:0] esperado, input string contexto);
    repeat (99) begin
      @(posedge clk);
      #1;
      check_luces(esperado, {contexto, " (antes del flanco 100)"});
    end
    @(posedge clk);
    #1;
    check_luces({esperado[0], esperado[3:1]}, {contexto, " (flanco 100)"});
  endtask

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    reset_local = 1'b1;

    // El harness mantiene reset activo durante dos flancos.
    wait (!rst);
    @(negedge clk);
    reset_local = 1'b0;
    #1;
    check_luces(4'b1000, "salida luego de reset");

    // Comprueba las cuatro fases y que la secuencia vuelva al estado inicial.
    avanzar_un_periodo(4'b1000, "fase s0");
    avanzar_un_periodo(4'b0100, "fase s1");
    avanzar_un_periodo(4'b0010, "fase s2");
    avanzar_un_periodo(4'b0001, "fase s3");

    // Reset debe tener prioridad sobre el avance y reiniciar ambas partes.
    @(negedge clk);
    reset_local = 1'b1;
    @(posedge clk);
    #1;
    check_luces(4'b1000, "reset durante la secuencia");
    @(negedge clk);
    reset_local = 1'b0;
    #1;
    check_luces(4'b1000, "salida luego del segundo reset");

    avanzar_un_periodo(4'b1000, "conteo luego del segundo reset");

    pass_all = 1'b1;
    done = 1'b1;
  end
endmodule

