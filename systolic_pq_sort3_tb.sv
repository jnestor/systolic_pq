//
// systolic_pq_sort3_tb: simple stimulus-only testbench for sort3
//

module systolic_pq_sort3_tb;
  parameter KW=8, VW=4;
  logic [KW+VW-1:0] a, b, c;
  logic [KW+VW-1:0] minv, medv, maxv;
  systolic_pq_sort3 #(.KW(KW), .VW(VW) DUV (.*);

  initial begin
    $monitor("time-%t, a=%h b=%h c = %h  |  minv=%h medv=%h maxv=%h",
             $time, a, b, c, minv, medv, maxv);
    a = 12'h000; b = 12'h000; c = 12'h000;
    #100;
    a = 12'h010; b = 12'h020; c = 12'h030;
    #100;
    a = 12'h010; b = 12'h030; c = 12'h020;
    #100;
    a = 12'h020; b = 12'h010; c = 12'h030;
    #100;
    a = 12'h020; b = 12'h030; c = 12'h010;
    #100;
    a = 12'h030; b = 12'h010; c = 12'h0310;
    #100;
    a = 12'h030; b = 12'h020; c = 12'h010;
    #100;
    a = 12'h330; b = 12'h220; c = 12'h220;
    #100;
    $stop;
  end


  module #(p) systolic_pq_sort3 (
      input logic [KW+VW-1:0] a, b, c,
      output logic [KW+VW-1:0] minv, medv, maxv);

endmodule
