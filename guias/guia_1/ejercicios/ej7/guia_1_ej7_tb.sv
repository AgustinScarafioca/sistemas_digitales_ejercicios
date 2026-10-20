module guia_1_ej7_tb (
  input logic clk,
  input logic rst,
  output logic done,
  output logic pass_all
);

    logic       data;
    logic [1:0] sel;

    logic [3:0] out_jerarquico;
    logic [3:0] out_plano;

    integer i;

    demux1a4_jerarquico dut_jerarquico (
        .data(data),
        .sel(sel),
        .out(out_jerarquico)
    );

    demux1a4_plano dut_plano (
        .data(data),
        .sel(sel),
        .out(out_plano)
    );

    initial begin

        done = 1'b0;
        pass_all = 1'b0;

        data = 1'b0;
        sel  = 2'b00;

        wait (!rst);

        for (i = 0; i < 8; i++) begin

            {data, sel} = i[2:0];

            #1;

            $display(
                "data=%b sel=%b jerarquico=%b plano=%b",
                data,
                sel,
                out_jerarquico,
                out_plano
            );

            if (out_jerarquico !== out_plano)
                $fatal(
                    1,
                    "Diferencia data=%b sel=%b: jerarquico=%b plano=%b",
                    data,
                    sel,
                    out_jerarquico,
                    out_plano
                );
        end 
        pass_all = 1'b1;
        done = 1'b1;
    end

endmodule
