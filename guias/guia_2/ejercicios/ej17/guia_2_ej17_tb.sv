module guia_2_ej17_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic load, ext;
  logic [3:0] data_in, data_out;
  integer errores;

  registro_extensor dut (
    .clk(clk),
    .load(load),
    .ext(ext),
    .data_in(data_in),
    .out(data_out)
  );

  task automatic check_output(input logic [3:0] expected, input string tag);
    if (data_out !== expected) begin
      $error("%s: esperado=%b, obtenido=%b", tag, expected, data_out);
      errores = errores + 1;
    end
  endtask

  // Cambia las entradas lejos del flanco activo, luego verifica el estado
  // y la salida combinacional después de que el registro haya actualizado.
  task automatic clock_and_check(input logic [3:0] expected, input string tag);
    @(posedge clk);
    #1;
    check_output(expected, tag);
  endtask

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    errores = 0;
    load = 1'b0;
    ext = 1'b0;
    data_in = '0;

    wait (!rst);

    // Carga y salida directa: se conservan los cuatro bits.
    @(negedge clk);
    load = 1'b1;
    data_in = 4'b1001;
    ext = 1'b0;
    clock_and_check(4'b1001, "carga con ext=0");

    // Con load desactivado, el registro debe conservar su valor.
    @(negedge clk);
    load = 1'b0;
    data_in = 4'b0110;
    clock_and_check(4'b1001, "retencion con load=0");

    // La extensión replica el bit 1 (signo) de los dos bits bajos.
    // 01 representa un valor no negativo y se extiende con ceros.
    @(negedge clk);
    load = 1'b1;
    data_in = 4'b1101;
    ext = 1'b1;
    clock_and_check(4'b0001, "extension de signo positivo");

    // 10 representa un valor negativo y se extiende con unos.
    @(negedge clk);
    data_in = 4'b0010;
    clock_and_check(4'b1110, "extension de signo negativo");

    // 11 también debe conservar el signo negativo al extender.
    @(negedge clk);
    data_in = 4'b1011;
    clock_and_check(4'b1111, "extension de -1");

    // Cambiar ext no debe alterar el contenido almacenado.
    @(negedge clk);
    load = 1'b0;
    ext = 1'b0;
    clock_and_check(4'b1011, "salida directa tras retencion");

    pass_all = (errores == 0);
    done = 1'b1;
    if (pass_all)
      $display("Todos los casos del ejercicio 17 pasaron.");
    else
      $display("Ejercicio 17: %0d caso(s) fallaron.", errores);
  end
endmodule

