//
//  Processing node for Lieserson's Systolic Priority Queue
//

module systolic_pq_proc #(parameter KW=8, VW=4)  (
    input logic clk, rst, enb,
    input logic [KW+VW-1:0] bi, ai, axi,
    output logic [KW+VW-1:0] bo, ao, axo);

  parameter logic [KW+VW-1:0] PQINF = '1;
  parameter logic [KW+VW-1:0] PQNEGINF = '0;
  
  logic [KW+VW-1:0] minv, medv, maxv;

  systolic_pq_sort3 U_SORT3 (.a(ai), .b(ao), .c(bi), .minv, .medv, .maxv);
  
  assign axo = minv;

  always_ff @(posedge clk)
    begin
      if (rst)
        begin
          bo <= PQINF;
          ao <= PQINF;
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
     end
endmodule: systolic_pq_proc
