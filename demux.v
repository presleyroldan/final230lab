module demux(
    input [3:0] op_sel,
    output reg add_en,
    output reg sub_en,
    output reg shl_en,
    output reg shr_en,
    output reg cmp_en,
    output reg and_en,
    output reg or_en,
    output reg xor_en,
    output reg nand_en,
    output reg nor_en,
    output reg xnor_en,
    output reg not_en,
    output reg neg_en,
    output reg sto_en,
    output reg swp_en,
    output reg load_en
);

    always @(*) begin
        add_en = 0;
        sub_en = 0;
        shl_en = 0;
        shr_en = 0;
        cmp_en = 0;
        and_en = 0;
        or_en = 0;
        xor_en = 0;
        nand_en = 0;
        nor_en = 0;
        xnor_en = 0;
        not_en = 0;
        neg_en = 0;
        sto_en = 0;
        swp_en = 0;
        load_en = 0;

        case (op_sel)
            4'h0: add_en = 1;
            4'h1: sub_en = 1;
            4'h2: shl_en = 1;
            4'h3: shr_en = 1;
            4'h4: cmp_en = 1;
            4'h5: and_en = 1;
            4'h6: or_en = 1;
            4'h7: xor_en = 1;
            4'h8: nand_en = 1;
            4'h9: nor_en = 1;
            4'hA: xnor_en = 1;
            4'hB: not_en = 1;
            4'hC: neg_en = 1;
            4'hD: sto_en = 1;
            4'hE: swp_en = 1;
            4'hF: load_en = 1;
            default: begin
                add_en = 0;
                sub_en = 0;
                shl_en = 0;
                shr_en = 0;
                cmp_en = 0;
                and_en = 0;
                or_en = 0;
                xor_en = 0;
                nand_en = 0;
                nor_en = 0;
                xnor_en = 0;
                not_en = 0;
                neg_en = 0;
                sto_en = 0;
                swp_en = 0;
                load_en = 0;
            end
        endcase
    end
endmodule
