//
//  Processing node 0 for Lieserson's Systolic Priority Queue
// This node interfaces with the outside world and passes
// information to the actual processing nodes P1-PN.
// Data is inserted and removed from the PQ using valid-ready interface/
// This module also generates timing signals for odd/even nodes and
// keeps track of the number of items currently in the PQ.
//

module #(parameter kW=8, VW=4) systolic_pq_proc0 (
    input logic clk, rst,
    output logic even, odd,
    input logic ivalid,
    input logic [KW+VW-1:0] idata,
    output logic irdy,
    output logic ovalid,
    output logic [KW+VW-1:0] odata,
    input logic ordy,
    output logic [KW+VW-1:0] bo, ao.
    input logic [KW+VW-1:0] axi,
    );

    // may want to move these to the main module?
    parameter logic [KW-1:0] PQINF = '1;
    parameter logic [KW-1:0] PQNEGINF = '0;
    localparam PQ_CAPACITY = 4;

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

    always_ff @(posedge clk) begin
      if (rst)
        begin
          b0 <= PQINF;
          a0 <= PQNEGINF;
          pq_count <= 0;
        end
      else if (ovalid && ordy )
        begin
          b0 <= PQINF;
          a0 <= PQINF;
          pq_count <= pq_count - 1;
        end
      else if (ivalid && irdy )
        begin
          b0 <= idata;
          a0 <= PQNEGINF;
          pq_count <= pq_count + 1;
        end
      else
        begin
          b0 <= PQINF;
          a0 <= PQNEGINF;
        end
    end

    assign irdy = (pq_count < PQ_CAPACITY) && even;

    assign ovalid = (pq_count > 0) && even;


endmodule: systolic_pq_proc0
