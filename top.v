module top(
    input clk,
    input btnC,
    input btnU,
    input [3:0] sw_op_sel,
    input [7:0] sw_input_bits,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
);

    wire [7:0] A_val;
    wire [7:0] B_val;
    wire [7:0] Y_val;
    wire div_clk;
    reg [3:0] selected_value;

    clock_div #(.DIVIDE_BY(17)) clk_div (
        .clk(clk),
        .reset(btnU),
        .div_clk(div_clk)
    );

    alu my_alu (
        .op_sel(sw_op_sel),
        .input_bits(sw_input_bits),
        .btnC(btnC),
        .btnU(btnU),
        .ledA(A_val),
        .ledB(B_val),
        .Y(Y_val)
    );

    assign led[15:8] = A_val;
    assign led[7:0] = B_val;

    seven_seg_scanner scanner (
        .div_clk(div_clk),
        .reset(btnU),
        .an(an)
    );

    always @(*) begin
        case (an)
            4'b1110: selected_value = sw_op_sel;
            4'b1101: selected_value = Y_val[3:0];
            4'b1011: selected_value = Y_val[7:4];
            4'b0111: selected_value = 4'b0000;
            default: selected_value = 4'b0000;
        endcase
    end

    seven_seg_decoder decoder (
        .digit(selected_value),
        .seg(seg)
    );
endmodule
