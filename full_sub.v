module full_subtractor(
    input a,
    input b,
    input bin,
    output diff,
    output bout
);
    assign diff = a ^ b ^ bin;
    assign bout = (~a & (b ^ bin)) | (b & bin);
endmodule

module full_sub_8bit(
    input [7:0] a,
    input [7:0] b,
    input bin,
    output [7:0] diff,
    output bout
);
    wire [7:0] borrow;

    full_subtractor sub0 (a[0], b[0], bin, diff[0], borrow[0]);
    full_subtractor sub1 (a[1], b[1], borrow[0], diff[1], borrow[1]);
    full_subtractor sub2 (a[2], b[2], borrow[1], diff[2], borrow[2]);
    full_subtractor sub3 (a[3], b[3], borrow[2], diff[3], borrow[3]);
    full_subtractor sub4 (a[4], b[4], borrow[3], diff[4], borrow[4]);
    full_subtractor sub5 (a[5], b[5], borrow[4], diff[5], borrow[5]);
    full_subtractor sub6 (a[6], b[6], borrow[5], diff[6], borrow[6]);
    full_subtractor sub7 (a[7], b[7], borrow[6], diff[7], bout);
endmodule

