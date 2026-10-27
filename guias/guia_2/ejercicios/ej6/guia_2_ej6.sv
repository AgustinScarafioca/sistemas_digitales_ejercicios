module shifter (
    input  logic         clk,
    input  logic         reset,
    input  logic         load,
    input  logic         shift,
    input  logic         serial_in,
    input  logic [7:0] data_in,
    output logic [7:0] data_out
);

    logic [7:0 ] bus_intermedio;

    always_ff @(posedge clk) begin
        if (reset)
            bus_intermedio <= 8'b0;
        else if (load)
            bus_intermedio <= data_in;
        else if (shift)
            bus_intermedio <= {bus_intermedio[6:0], serial_in};
        /*else
            bus_intermedio <= bus_intermedio;*/
    end

    assign data_out = bus_intermedio;

endmodule
