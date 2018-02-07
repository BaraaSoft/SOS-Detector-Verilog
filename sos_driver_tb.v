`timescale 1ns/100ps
`include "sos_driver.v"

module sos_driver_tb;

   wire clkW, out;
   integer k=0;
   reg clk = 1'b0;
   assign clkW = clk;

   sos_driver the_circuit(.clk(clkW),.dataOut(out));

   initial begin

      $dumpfile("sos_driver.vcd");
      $dumpvars(0, sos_driver_tb);

      for (k=0; k<128; k=k+1)begin
            #10;
            clk = ~clk;
            $display("done testing case %d", k);
        end
      $finish;

   end


endmodule

// To execute::>>
//1- iverilog sos_driver.v
//2- iverilog -o a.out sos_driver_tb.v
//3- vvp a.out
//4 -open -a Scansion sos_driver.vcd