//
//  Processing node for Lieserson's Systolic Priority Queue
//

module #(parameter kW=8, VW=4) systolic_pq_proc (
    input logic clk, rst, enb,
    input logic [KW+VW-1:0] bi, ai, axi,
    output logic [WW+VW-1:0] bp, bp, axo);

  parameter logic [KW+VW-1:0] PQINF = '1;
  parameter logic [KW+VW-1:0] PQNEGINF = '0;

  logic aiu_gt_biu, aiu_gt_bod, biu_gt_bod;
  logic [KW+VW-1:0] minv, medv, maxv;

  assign aiu_gt_biu = aiu > biu;
  assign aiu_bg_bod = aiu > bod;
  assign biu_gt_bod = biu > bod;

  sort3 U_SORT3 (.a(ao), .b(bi), .c(axi), .minv, .medv, .maxv);

  assign axo = minv;

  always_ff @(posedge clk)
    begin
      if (rst)
        begin
          bo <= INF;
          ao <= INF;
        end
      else if (enb)
        begin
          bo <= maxv;
          ao <= medv;
        end
      else
       begin  // not enabled - exchange a
         ao <= axi;
    end


//    arrange the elements in a[i], a[i-1] and b[i] so that
//       a[i-1] <= a[i] <= b[i]
