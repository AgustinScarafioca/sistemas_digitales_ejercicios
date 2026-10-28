module controlador_semaforo(
    input  logic clk,
    input  logic reset,
    output logic s0, s1, s2, s3
);

    logic [6:0] cuenta_actual;
    logic [6:0] cuenta_siguiente;
    logic       es_100;
    logic [3:0] estado_semaforo;

    assign cuenta_siguiente = cuenta_actual + 7'd1;

    comparador_100 comparador (
        .valor(cuenta_siguiente),
        .es_100(es_100)
    );

    rotacion_bus rotacion_bus (
        .clk   (clk),
        .reset (reset),
        .enable(es_100),
        .salida(estado_semaforo)
    );

    contador_7b contador_7b (
        .clk             (clk),
        .reset           (reset),
        .reiniciar_cuenta(es_100),
        .cuenta          (cuenta_actual)
    );

    assign s0 = estado_semaforo[3];
    assign s1 = estado_semaforo[2];
    assign s2 = estado_semaforo[1];
    assign s3 = estado_semaforo[0];
endmodule

module comparador_100 (
    input  logic [6:0] valor,
    output logic       es_100
);

    assign es_100 = (valor == 7'd100);

endmodule

module rotacion_bus (
    input  logic       clk,
    input  logic       reset,
    input  logic       enable,
    output logic [3:0] salida
);
    
    always_ff @(posedge clk) begin
        if (reset)
            salida <= 4'b1000;
        else if (enable)
            salida <= {salida[0], salida[3:1]};
    end

endmodule

module contador_7b (
    input  logic       clk,
    input  logic       reset,
    input  logic       reiniciar_cuenta,
    output logic [6:0] cuenta
);

    always_ff @(posedge clk) begin
        if (reset)
            cuenta <= 7'd0;
        else if (reiniciar_cuenta)
            cuenta <= 7'd0;
        else
            cuenta <= cuenta + 1;
    end

endmodule
