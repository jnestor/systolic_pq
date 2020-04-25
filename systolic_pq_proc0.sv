//
//  Processing node 0 for Lieserson's Systolic Priority Queue
//

module systolic_pq_proc0 #(parameter KW=8, VW=4) (
    input logic clk, rst,
    output logic even, odd,
    input logic ivalid,
    input logic [KW+VW-1:0] idata,
    output logic irdy,
    input logic ovalid,
    input logic ordy,
    output logic [KW+VW-1:0] bo, ao,
    );

    // may want to move these to the main module?
    parameter logic [KW+VW-1:0] PQINF = '1;
    parameter logic [KW+VW-1:0] PQNEGINF = '0;

    parameter PQ_CAPACITY = 4;

    //--------------------------------------------------
    // Generate odd, even enables
    //--------------------------------------------------

    always @(posedge clk)
      if (rst) odd <= 0;
      else odd <= !odd;

    assign even = !odd;


    //--------------------------------------------------
    // write logic to place stuff in the queue
    //--------------------------------------------------

    logic [2:0] pq_count;

    assign irdy = (pq_count <= PQ_CAPACITY) && even;

    always_ff @(posedge clk) begin
      if (rst)
        begin
          bo <= PQINF;
          ao <= PQNEGINF;
          pq_count <= 0;
        end
      else if (ovalid && ordy )
        begin
          bo <= PQINF;
          ao <= PQINF;
          pq_count <= pq_count - 1;
        end
      else if (ivalid && irdy )
        begin
          bo <= idata;
          ao <= PQNEGINF;
          pq_count <= pq_count + 1;
        end
      else
        begin // default - insert "infinite" weight
          bo <= PQINF;
          ao <= PQNEGINF;
        end
    end

endmodule: systolic_pq_proc0
