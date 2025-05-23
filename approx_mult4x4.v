module approx_mult4x4 (
    input  [3:0] A,
    input  [3:0] B,
    output [7:0] result
);
    // Partial products
    wire [3:0] pp0 = A & {4{B[0]}};
    wire [3:0] pp1 = A & {4{B[1]}};
    wire [3:0] pp2 = A & {4{B[2]}};
    wire [3:0] pp3 = A & {4{B[3]}};

    // Lower-part OR Adder (LOA) for LSBs (bits 0,1)
    assign result[0] = pp0[0];
    assign result[1] = pp0[1] | pp1[0];

    // Approximate sum for result[2]: OR for partial products, no carry
    assign result[2] = pp0[2] | pp1[1] | pp2[0];

    // Approximate sum for result[3]: OR for partial products, no carry
    assign result[3] = pp0[3] | pp1[2] | pp2[1] | pp3[0];

    // Accurate 2-bit adder for higher bits (segmented accurate adder)
    wire sum4_0, sum4_1, carry4_0, carry4_1;

    // result[4] = pp1[3] + pp2[2] + pp3[1]
    assign sum4_0   = pp1[3] ^ pp2[2] ^ pp3[1];
    assign carry4_0 = (pp1[3] & pp2[2]) | (pp2[2] & pp3[1]) | (pp1[3] & pp3[1]);

    // result[5] = pp2[3] + pp3[2] + carry from previous
    assign sum4_1   = pp2[3] ^ pp3[2] ^ carry4_0;
    assign carry4_1 = (pp2[3] & pp3[2]) | (pp3[2] & carry4_0) | (pp2[3] & carry4_0);

    // result[6] = pp3[3] + carry from previous
    assign result[4] = sum4_0;
    assign result[5] = sum4_1;
    assign result[6] = pp3[3] | carry4_1;

    // result[7] is always zero for unsigned 4x4 multiplication
    assign result[7] = 1'b0;

endmodule
