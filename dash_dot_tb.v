`timescale 1ns/100ps
`include "sos_driver.v"
`include "dash_dot.v"

module dash_dot_tb;

   integer k;
   integer clock = 1'b0;
   integer clockB = 1'b0;

   wire clkk;
   wire clkB;
   assign clkk = clock;
   assign clkB = clock;

   wire data_in;
   wire ready;
  
   wire[1:0]outPut;
   reg[1:0] prevOutput;
   reg[1:0] outz;



   //assign {A,B} = k;
   //sos_driver driver(.clk(clkk),.dataOut(data_in));
   sos_driver driver(clkk,data_in);
   dash_dot the_circuit(clkB,data_in,ready,outPut);
   
   always begin
        #10 clock = ~clock;
    end
    
   initial begin
      $dumpfile("dash_dot_tb.vcd");
      $dumpvars(0, dash_dot_tb);

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
//iverilog dash_dot.v
//iverilog -o a.out dash_dot_tb.v
//vvp a.out
// open -a Scansion dash_dot_tb.vcd