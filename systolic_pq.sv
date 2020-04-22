module #(parameter kW=8, VW=4) systolic_pq(
  input logic clk, rst, ivalid,
  input logic [KV+VW-1:0] idata,
  output logic irdy,
  output logic ovalid,
  output logic [KW+VW-1:0] odata,
  input logic ordy
  );

  logic even, odd;

  logic [KW+VW-1:0] a0, a0x, a1, a1x, a2, a2x, a3,
                    a3x, a4, a4x, b0, b1, b2, b3, b4;

  systolic_pq_proc0 #(.KW(KW),.VW(VW)) U_PROC0 (
      .clk, .rst, .ivalid, .idata, .irdy,
      .ovalid, .odata, .ordy, .bo(b0), .ao(a0), .axi(a0x)
  );

  systolic_pq_proc #(.KW(KW),.VW(VW)) U_PROC1(
      .clk, .rst, .enb(odd), .bi(b0), .ai(a0), .axi(a1x),
      .bo(b1), .ao(a1), .axo(a0x)
  );

  systolic_pq_proc #(.KW(KW),.VW(VW)) U_PROC2(
      .clk, .rst, .enb(even), .bi(b1), .ai(a1), .axi(a2x),
      .bo(b2), .ao(a2), .axo(a1x)
  );

  systolic_pq_proc #(.KW(KW),.VW(VW)) U_PROC3(
      .clk, .rst, .enb(odd), .bi(b2), .ai(a2), .axi(a3x),
      .bo(b3), .ao(a3), .axo(a2x)
  );

  systolic_pq_proc #(.KW(KW),.VW(VW)) U_PROC4(
      .clk, .rst, .enb(even), .bi(b3), .ai(a3), .axi(a4),
      .bo(b4), .ao(a4), .axo(a3ßx)
  );

  assign odata = a1;

endmodule: systolic_pq
