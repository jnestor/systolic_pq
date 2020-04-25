//
// systolic_pq_sort3_tb: simple stimulus-only testbench for sort3
//

module systolic_pq_sort3_tb;
  parameter KW=8, VW=4;
  logic [KW+VW-1:0] a, b, c;
  logic [KW+VW-1:0] minv, medv, maxv;
  systolic_pq_sort3 #(.KW(KW), .VW(VW)) DUV  (.*);

  initial begin
    $monitor("time-%t, a=%h b=%h c = %h  |  minv=%h medv=%h maxv=%h",
             $time, a, b, c, minv, medv, maxv);
    a = 12'h000; b = 12'h000; c = 12'h000;
    #100;
    a = 12'h01a; b = 12'h02b; c = 12'h03c;
    #100;
    a = 12'h01a; b = 12'h03b; c = 12'h02c;
    #100;
    a = 12'h02a; b = 12'h01b; c = 12'h03c;
    #100;
    a = 12'h02a; b = 12'h03b; c = 12'h01c;
    #100;
    a = 12'h03a; b = 12'h01b; c = 12'h031c;
    #100;
    a = 12'h03a; b = 12'h02b; c = 12'h01c;
    #100;
    a = 12'h33a; b = 12'h22b; c = 12'h22c;
    #100;
    a = 12'h11a; b = 12'h11b; c = 12'h11c;
    #100;
    $stop;
  end

endmodule
