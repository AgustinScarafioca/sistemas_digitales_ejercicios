module inversor_controlado #(
    parameter int N = 3
    ) (
        input  logic [N-1:0] in,
        input  logic         invert,
        output logic [N-1:0] out
    );

    // aca {} funciona como repetir invert N veces osea arma un bus de n bits en 
    //base a invert para comparar con xor
    assign out = in ^ {N{invert}};

endmodule
