module alu (
    input  logic       clk,
    input logic [3:0] data_in_a,
    input logic [3:0] data_in_b,
    input logic load_a,
    input logic load_b,
    input logic load_resultado,
    input  logic [1:0] op,
    input  logic       read_resultado,
    output logic [3:0] out
);

    logic [3:0] registro_a;
    logic [3:0] registro_b;
    logic [4:0] suma_extendida;
    logic [4:0] resta_extendida;
    logic zero_flag, negative_flag, overflow_flag, carry_flag;

    always_ff @(posedge clk) begin
        if (load_a)
            registro_a <= data_in_a;
        if (load_b)
            registro_b <= data_in_b;
    end

    logic [3:0] resultado_alu;
    logic [3:0] registro_resultado;
    logic zero_calc;
    assign suma_extendida = {1'b0, registro_a} + {1'b0, registro_b};
    assign resta_extendida = {1'b0, registro_a} - {1'b0, registro_b};
    
    always_comb begin
        case (op)
            2'b00: resultado_alu = registro_a + registro_b;
            2'b01: resultado_alu = registro_a - registro_b;
            2'b10: resultado_alu = registro_a | registro_b;
            2'b11: resultado_alu = registro_a & registro_b;
            default: resultado_alu = registro_a;
        endcase
    end

    logic negative_calc;
    logic overflow_suma;
    logic overflow_resta;
    logic carry_calc;
    logic overflow_calc;

    always_comb begin
        case (op)
            2'b00: carry_calc = suma_extendida[4];
            2'b01: carry_calc = resta_extendida[4];
            2'b10: carry_calc = 1'b0;
            2'b11: carry_calc = 1'b0;
            default: carry_calc = 1'b0;
        endcase
    end
    
    assign zero_calc = (resultado_alu == 4'b0000);
    assign negative_calc = resultado_alu[3];
    assign overflow_suma = (registro_a[3] == registro_b[3]) && (resultado_alu[3] != registro_a[3]);
    assign overflow_resta = (registro_a[3] != registro_b[3]) && (resultado_alu[3] != registro_a[3]);

    always_comb begin
        case (op)
            2'b00: overflow_calc = overflow_suma;
            2'b01: overflow_calc = overflow_resta;
            default: overflow_calc = 1'b0;
        endcase
    end

    always_ff @(posedge clk) begin
        if(load_resultado) begin
            registro_resultado <= resultado_alu;
            zero_flag <= zero_calc;
            negative_flag <= negative_calc;
            overflow_flag <=overflow_calc;
            carry_flag <= carry_calc;
        end
    end

    assign out = read_resultado ? registro_resultado : 4'b0000;
    
endmodule
