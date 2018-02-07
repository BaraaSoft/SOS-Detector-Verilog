module sos_driver ( input clk,output dataOut
  
);

reg dataOut;
reg [3:0]state;
reg dotflag;
reg dashflag;
reg startCounterB;
reg [4:0] counter;
reg [4:0] counterB;

wire clk;

always @(posedge clk)begin
    counter <= counter +1;
    if(counter == 4'd5)begin // counter == 4'd5
        dotflag <= 1'b1;
        counter <= 4'd0; 
    end
    if(startCounterB == 1'b1)begin
        counterB <= counterB+1;
    end
    if (counterB == 4'd9) begin
      dashflag <=1'b1;
      counterB <=4'd0;
    end
    case (state)
      4'd0: begin
        dataOut <= 1'b0;
        if (dotflag == 1'b0) begin
            state <= 3'd1;
        end else begin
            state <= 3'd3;
        end
      end
      4'd1:begin
        dataOut <= 1'b1;
        if(dotflag == 1'b0)begin
            state <= 3'd0;//***CH
        end else begin
            if (dashflag == 1'b0) begin
              state <= 3'd5;
              counter <=4'd00; 
              startCounterB <= 1'b1;
            end
        end
      end
      4'd2:begin
        dataOut <= 1'b0;
        state <= 3'd0; 
      end
      4'd3:begin
        dataOut <= 1'b0;
        state <= 3'd4; 
        dashflag <=1'b0; //*****CH
      end
      4'd4:begin
        dataOut <= 1'b0;
        if (dashflag == 1'b0) begin
          state <= 3'd1; 
        end else begin
          state <= 3'd0;
          dotflag <= 1'b0; 
        end
      end
      4'd5:begin
        dataOut <= 1'b1;
        state <= 3'd6; 
      end
      4'd6:begin
        dataOut <= 1'b1;
        state <= 3'd7; 
      end
      4'd7:begin
        dataOut <= 1'b0;
        if (dashflag == 1'b0) begin
          state <= 3'd1;
        end else begin
          state <= 3'd4; //**** chp 3'd3;
          startCounterB <= 1'b0;
          counter <= 4'd5; //***chp 3'd0
        end 
      end
      default: begin
        state <=3'd0;
        dotflag <= 1'b0;
        dashflag <= 1'b0;
        counter <=2'b00;
        counterB <=5'd0;
        startCounterB<=0;
        //dataOut <= 1'b0;
      end
    endcase
  
end

endmodule // 


//ME:
//iverilog sos_driver.v
//iverilog -o a.out sos_driver_tb.v
//vvp a.out
// open -a scansion sos_driver_tb.vcd