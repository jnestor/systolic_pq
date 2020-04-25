`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/23/2020 03:43:43 PM
// Design Name:
// Module Name: systolic_pq_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module systolic_pq_tb;


  parameter KW=8, VW=4;

  logic clk, rst, ivalid;
  logic [KW+VW-1:0] idata;
  logic irdy;
  logic ovalid;
  logic [KW+VW-1:0] odata;
  logic ordy;

  systolic_pq #(.KW(KW), .VW(VW)) DUV (
    .clk, .rst, .ivalid, .idata, .irdy, .ovalid, .odata, .ordy
  );

  task insert (input logic [KW+VW-1:0] kv);
    idata = kv;
    ivalid <= 1;
    while (!irdy) @(negedge clk);
    @(negedge clk);
    ivalid <= 0;
  endtask: insert

  task extract ();
    ordy <= 1;
    while (!ovalid) @(negedge clk);
    @(negedge clk) #1;
    ordy <=0;
  endtask: extract

  always begin
    clk = 0; #5;
    clk = 1; #5;
  end

  initial begin
    rst = 1;
    ivalid = 0;
    idata = 12'h010;
    ordy = 0;

    repeat (2) @(negedge clk);
    rst = 0;
    @(negedge clk);
    insert(12'h111);
    repeat (4) @(negedge clk);
    insert(12'h202);
    @(negedge clk);
    insert(12'h143);
    repeat (3) @(negedge clk);
    insert(12'h304);
    repeat (10) @(negedge clk);
    extract();
    repeat (3) @(negedge clk);
    insert(12'h155);
    repeat (8) @(negedge clk);
    extract();
    repeat (5) @(negedge clk);
   $stop;
  end


endmodule
