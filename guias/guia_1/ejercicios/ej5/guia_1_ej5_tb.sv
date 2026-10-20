module guia_1_ej5_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);
  logic data;
  logic [1:0] sel;
  logic [3:0] out;
  logic [3:0] esperado;
  integer i;

  demux1a4 dut (.data(data), .sel(sel), .out(out));

  initial begin
    done = 1'b0;
    pass_all = 1'b0;
    data = 1'b0;
    sel = 2'b00;
    wait (!rst);

    for (i = 0; i < 8; i++) begin
      {data, sel} = i[2:0];
      esperado = data ? (4'b0001 << sel) : 4'b0000;
      #1;

      $display("data=%b sel=%b out=%b esperado=%b",
               data, sel, out, esperado);
      if (out !== esperado)
        $fatal(1, "demux1a4 data=%b sel=%b: salida=%b, esperada=%b",
               data, sel, out, esperado);
    end

    pass_all = 1'b1;
    done = 1'b1;
  end
endmodule
