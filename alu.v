module alu(
    input [3:0] op_sel,
    input [7:0] input_bits,
    input btnC,
    input btnU,
    output reg [7:0] ledA,
    output reg [7:0] ledB,
    output reg [7:0] Y
);

    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] add_result;
    wire [7:0] sub_result;
    wire [7:0] shift_result;
    wire cout, bout;

    wire add_en, sub_en, shl_en, shr_en, cmp_en;
    wire and_en, or_en, xor_en, nand_en, nor_en;
    wire xnor_en, not_en, neg_en, sto_en, swp_en, load_en;

    demux control_demux (
        .op_sel(op_sel),
        .add_en(add_en),
        .sub_en(sub_en),
        .shl_en(shl_en),
        .shr_en(shr_en),
        .cmp_en(cmp_en),
        .and_en(and_en),
        .or_en(or_en),
        .xor_en(xor_en),
        .nand_en(nand_en),
        .nor_en(nor_en),
        .xnor_en(xnor_en),
        .not_en(not_en),
        .neg_en(neg_en),
        .sto_en(sto_en),
        .swp_en(swp_en),
        .load_en(load_en)
    );

    full_add_8bit adder (
        .a(A),
        .b(B),
        .cin(0),
        .sum(add_result),
        .cout(cout)
    );

    full_sub_8bit subtractor (
        .a(A),
        .b(B),
        .bin(0),
        .diff(sub_result),
        .bout(bout)
    );

    twos_complement neg_module (
        .a(A),
        .neg(neg_result)
    );

    always @(posedge btnU) begin
        A <= 8'b0;
        B <= 8'b0;
        Y <= 8'b0;
    end

    always @(posedge btnC) begin
    case (op_sel)
        4'h0: Y <= add_result;
        4'h1: Y <= sub_result;
        4'h2: Y <= A << 1;
        4'h3: Y <= A >> 1;
        4'h4: begin
            if (A == B) Y <= 8'b0;
            else (A > B) Y <= 8'b1;
        end
        4'h5: Y <= A & B;
        4'h6: Y <= A | B;
        4'h7: Y <= A ^ B;
        4'h8: Y <= ~(A & B);
        4'h9: Y <= ~(A | B);
        4'hA: Y <= ~(A ^ B);
        4'hB: Y <= ~A;
        4'hC: Y <= neg_result;
        4'hD: A <= Y;
        4'hE: begin
            A = A ^ B;
            B = A ^ B;
            A = A ^ B;
        end
        4'hF: A <= input_bits;
        default: Y <= 8'b0;
    endcase

    ledA <= A;
    ledB <= B;
end


endmodule
