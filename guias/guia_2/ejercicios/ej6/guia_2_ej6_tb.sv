module guia_2_ej6_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic reset;
  logic load;
  logic shift;
  logic serial_in;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic [7:0] esperado;
  integer errores;

  shifter dut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .shift(shift),
    .serial_in(serial_in),
    .data_in(data_in),
    .data_out(data_out)
  );

  task automatic verificar(input logic [7:0] valor, input string caso_prueba);
    if (data_out !== valor) begin
      $error("%s: esperado=%b, obtenido=%b", caso_prueba, valor, data_out);
      errores = errores + 1;
    end
  endtask

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    errores = 0;
    reset = 1'b0;
    load = 1'b0;
    shift = 1'b0;
    serial_in = 1'b0;
    data_in = '0;

    wait (!rst);

    // Reset síncrono y su prioridad sobre carga y desplazamiento.
    @(negedge clk);
    reset = 1'b1;
    load = 1'b1;
    shift = 1'b1;
    data_in = 8'hA5;
    serial_in = 1'b1;
    @(posedge clk);
    #1;
    verificar(8'h00, "reset prioritario");

    // La carga tiene prioridad sobre shift.
    @(negedge clk);
    reset = 1'b0;
    load = 1'b1;
    shift = 1'b1;
    data_in = 8'b1001_0110;
    @(posedge clk);
    #1;
    esperado = 8'b1001_0110;
    verificar(esperado, "carga prioritaria sobre shift");

    // Desplazamiento a izquierda e ingreso del bit serial por el LSB.
    @(negedge clk);
    load = 1'b0;
    shift = 1'b1;
    serial_in = 1'b1;
    @(posedge clk);
    #1;
    esperado = {esperado[6:0], 1'b1};
    verificar(esperado, "shift izquierdo con serial_in=1");

    @(negedge clk);
    serial_in = 1'b0;
    @(posedge clk);
    #1;
    esperado = {esperado[6:0], 1'b0};
    verificar(esperado, "shift izquierdo con serial_in=0");

    // Con ambos controles bajos, el registro conserva su valor.
    @(negedge clk);
    shift = 1'b0;
    data_in = 8'hFF;
    @(posedge clk);
    #1;
    verificar(esperado, "retención");

    pass_all = (errores == 0);
    done = 1'b1;
  end
endmodule

