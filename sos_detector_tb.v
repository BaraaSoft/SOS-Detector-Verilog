`timescale 1ns/100ps
`include "sos_driver.v"
`include "sos_driver_test.v"
`include "dash_dot.v"
`include "sos_detector.v"

module sos_detector_tb;

   integer k;
   integer clock = 1'b0;
   integer clockB = 1'b0;

   wire clkk;
   wire clkB;
   wire clkC;
   assign clkk = clock;
   assign clkB = clock;
   assign clkC = clock;

   wire data_in;
   wire ready;
  
   wire[1:0]outPut;
   reg[1:0] prevOutput;
   reg[1:0] outz;
   wire[7:0] SOS_DATA;



   //assign {A,B} = k;
   //sos_driver driver(.clk(clkk),.dataOut(data_in));
   sos_driver_test driver_test(clkk,data_in);
   //sos_driver driver(clkk,data_in);
   dash_dot the_circuit(clkB,data_in,ready,outPut);
   sos_detector sos_circuit(clkC,ready,outPut,SOS_DATA);
   
   always begin
        #10 clock = ~clock;
    end
    
   initial begin
      $dumpfile("sos_detector_tb.vcd");
      $dumpvars(0, sos_detector_tb);

// *********** Test Cases ********** //
        for (k=0; k<128; k=k+1)begin
            #10;
            if (ready == 1'b1 && outPut== 2'b00 && clock == 1'b0 ) begin
                $display("Signal = .");
            end else if(ready == 1'b1 && outPut== 2'b10 && clock == 1'b0  ) begin
                $display("Signal = Space");
            end else if(ready == 1'b1 && outPut== 2'b11 && clock == 1'b0 ) begin
                $display("Signal = _");
                end
        end
// *********** Detecting SOS ********** //

      $finish;
   end
   

endmodule

// To execute::>>
//iverilog sos_detector.v
//iverilog -o a.out sos_detector_tb.v
//vvp a.out
// open -a Scansion sos_detector_tb.vcd