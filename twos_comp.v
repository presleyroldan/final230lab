module twos_complement(
    input [7:0] a,
    output [7:0] neg
);
    assign neg = ~a + 8'b00000001;
endmodule

