//
// Sort three values into minimum, median, and maximum values
// TODO: add key/value and sort by key only
//

module #(parameter KW=8, VW=4) systolic_pq_sort3 (
    input logic [KW+VW-1:0] a, b, c,
    output logic [KW+VW-1:0] minv, medv, maxv);

  logic [KW-1:0] ka, ab, kc;

  // extract the keys
  assign ka = a[KW+VW-1:VW];
  assign kb = b[KW+VW-1:VW];
  assign kc = c[KW+VW-1:VW];

  assign a_gt_b = ka > kb;
  assign a_gt_c = ka > kc;
  assign b_gt_c = kb > kc;

  always_comb begin
    unique case ({a_gt_b, a_gt_c, b_gt_c})
      3'b000 : begin
        minv = a;
        medv = b;
        maxv = c;
      end
      3'b001 : begin
        minv = a;
        medv = c;
        maxv = b;
      end
      3'b100 : begin
        minv = b;
        medv = a;
        maxv = c;
      end
      3'b011 : begin
        minv = c;
        medv = a;
        maxv = b;
      end
      3'b110 : begin
        minv = b;
        medv = c;
        maxv = a;
      end
      3'b111 : begin
        minv = c;
        medv = b;
        maxv = a;
      end
      // remaining cases 3'b010, 3'b101 cannot occur!
    endcase
  end
endmodule : sort3
