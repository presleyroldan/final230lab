module seven_seg_scanner(
    input div_clk,
    input reset,
    output reg [3:0] an
);
    reg [1:0] scan_count;

    always @(posedge div_clk or posedge reset) begin
        if (reset) begin
            scan_count <= 0;
            an <= 4'b1110;
        end else begin
            scan_count <= scan_count + 1;
            case (scan_count)
                2'b00: an <= 4'b1110;
                2'b01: an <= 4'b1101;
                2'b10: an <= 4'b1011;
                2'b11: an <= 4'b0111;
                default: an <= 4'b1111;
            endcase
        end
    end
endmodule
