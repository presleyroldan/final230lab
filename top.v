module top(
    input clk,
    input btnC,
    input btnU,
    input [15:0] sw,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
);

    wire [3:0] sw_sel;
    assign sw_sel = sw[3:0];
    
    wire [15:8] sw_bits;
    assign sw_bits = sw[15:8];
    
    
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
        .op_sel(sw_sel),
        .input_bits(sw_bits),
        .btnC(btnC),
        .btnU(btnU),
        .ledA(A_val),
        .ledB(B_val),
        .Y(Y_val)
    );

    assign led = {A_val,B_val};

    seven_seg_scanner scanner (
        .div_clk(div_clk),
        .reset(btnU),
        .an(an)
    );

    always @(*) begin
        case (an)
            4'b1110: selected_value = sw_sel;
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