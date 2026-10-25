module guia_2_ej20_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic [3:0] data_in_a, data_in_b;
  logic load_a, load_b, load_resultado;
  logic [1:0] op;
  logic read_resultado;
  logic [3:0] out;
  integer errores;

  alu dut (
    .clk(clk),
    .data_in_a(data_in_a),
    .data_in_b(data_in_b),
    .load_a(load_a),
    .load_b(load_b),
    .load_resultado(load_resultado),
    .op(op),
    .read_resultado(read_resultado),
    .out(out)
  );

  task automatic check_output(input logic [3:0] expected, input string tag);
    if (out !== expected) begin
      $error("%s: esperado=%b, obtenido=%b", tag, expected, out);
      errores = errores + 1;
    end
  endtask

  task automatic load_operands(input logic [3:0] a, input logic [3:0] b);
    @(negedge clk);
    data_in_a = a;
    data_in_b = b;
    load_a = 1'b1;
    load_b = 1'b1;
    load_resultado = 1'b0;
    @(posedge clk);
    #1;
    @(negedge clk);
    load_a = 1'b0;
    load_b = 1'b0;
  endtask

  task automatic execute_and_check(
    input logic [1:0] operation,
    input logic [3:0] expected,
    input string tag
  );
    op = operation;
    load_resultado = 1'b1;
    read_resultado = 1'b1;
    @(posedge clk);
    #1;
    check_output(expected, tag);
    @(negedge clk);
    load_resultado = 1'b0;
  endtask

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    errores = 0;
    data_in_a = '0;
    data_in_b = '0;
    load_a = 1'b0;
    load_b = 1'b0;
    load_resultado = 1'b0;
    op = 2'b00;
    read_resultado = 1'b0;

    wait (!rst);

    // Cargar dos operandos y verificar las cuatro operaciones.
    load_operands(4'd3, 4'd5);
    execute_and_check(2'b00, 4'd8, "suma 3 + 5");
    execute_and_check(2'b01, 4'hE, "resta 3 - 5");
    execute_and_check(2'b10, 4'd7, "OR 3 | 5");
    execute_and_check(2'b11, 4'd1, "AND 3 & 5");

    // La salida debe quedar en cero cuando se deshabilita su lectura,
    // aunque el resultado siga almacenado.
    read_resultado = 1'b0;
    #1;
    check_output(4'b0000, "lectura deshabilitada");
    read_resultado = 1'b1;
    #1;
    check_output(4'd1, "lectura del resultado almacenado");

    // Cargar operandos nuevos sin cargar el resultado no debe modificar
    // el resultado que ya estaba registrado.
    load_operands(4'd15, 4'd1);
    check_output(4'd1, "resultado retenido al cargar operandos");

    // La suma y la resta conservan solamente los cuatro bits bajos.
    execute_and_check(2'b00, 4'd0, "suma truncada 15 + 1");
    execute_and_check(2'b01, 4'hE, "resta truncada 15 - 1");

    // Un ciclo sin load_resultado no debe reemplazar el resultado guardado.
    op = 2'b10;
    load_resultado = 1'b0;
    @(negedge clk);
    data_in_a = 4'd0;
    data_in_b = 4'd0;
    load_a = 1'b1;
    load_b = 1'b1;
    @(posedge clk);
    #1;
    load_a = 1'b0;
    load_b = 1'b0;
    check_output(4'hE, "resultado retenido sin load_resultado");

    pass_all = (errores == 0);
    done = 1'b1;
    if (pass_all)
      $display("Todos los casos del ejercicio 20 pasaron.");
    else
      $display("Ejercicio 20: %0d caso(s) fallaron.", errores);
  end
endmodule

