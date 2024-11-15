module clock_div #(
    parameter DIVIDE_BY = 17
)(
    input clk,
    input reset,
    output reg div_clk
);
    reg [DIVIDE_BY-1:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            div_clk <= 0;
        end else if (counter == (1 << (DIVIDE_BY - 1)) - 1) begin
            div_clk <= ~div_clk;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule