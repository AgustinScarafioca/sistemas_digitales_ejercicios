module guia_2_ej5_tb #(
  parameter int N = 4
  ) (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);

  logic       reset;
  logic       write_enable;
  logic [N-1:0] data_in;
  logic [N-1:0] data_out;
  logic [N-1:0] esperado;
  integer errores;

  register #(
    .N(N)
  ) dut (
      .clk(clk),
      .reset(reset),
      .write_enable(write_enable),
      .data_in(data_in),
      .data_out(data_out)
  );

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    errores = 0;

    // Prueba 1: reset
    reset = 1'b1;
    write_enable = 1'b0;
    data_in = 4'b1010;

    wait (!rst);

    @(posedge clk);
    #1;

    if (data_out !== '0) begin
      $error("Error en reset: data_out=%b", data_out);
      errores = errores + 1;
    end

    // Prueba 2: escritura

    reset = 1'b0;
    write_enable = 1'b1;
    data_in = N'(8'b1010_1101);

    esperado = data_in;

    @(posedge clk);
    #1;

    if(data_out !== esperado) begin
      $error("Error en escritura: esperado=%b, obtenido=%b", data_in, data_out);
      errores = errores + 1;
    end

    // Prueba 3: conservación

    reset = 1'b0;
    write_enable = 1'b0;
    data_in = 4'b0010;

    @(posedge clk);
    #1;

    if (data_out !== esperado) begin 
        $error("Error en conservacion: esperado=1101, obtenido=%b", data_out);
      errores = errores + 1;      
    end

    // Prueba 4: prioridad del reset

    reset = 1'b1;
    write_enable = 1'b1;
    data_in = 4'b1111;

    @(posedge clk);
    #1;

    if (data_out !== '0) begin
        $error("Error en prioridad: esperado=0000, obtenido=%b", data_out);
        errores = errores + 1;
    end

    pass_all = (errores == 0);
    done = 1'b1;
  end
endmodule
