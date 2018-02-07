//`include "dash_dot.v"
module sos_detector (input clk,input readySignal,input[1:0]dataIn,output[7:0]sosOutput);
reg[1:0] counterA;
reg[4:0] state;
reg[1:0] initialize;
reg[7:0] sosOutput;

always @(posedge readySignal or negedge clk)begin
    
    if (~clk && readySignal) begin
        if(counterA >=2'd2)begin
            counterA <= 2'd0;
        end
        case (state)
        4'd0: begin // OUT S
            if (dataIn == 2'b00) begin
                counterA <= counterA +2'd1;
                if(counterA == 2'd2 )begin
                    state <= 4'd1;
                    sosOutput <= 8'h73;
                end else begin
                    state <= 4'd0;
                    sosOutput <= 8'h00;
                end
            end
        end
        4'd1:begin
            if (dataIn == 2'b10) begin
              state <= 4'd2;
            end else begin
              state <= 4'd0;
            end
        end
        4'd2:begin // OUT O
            if (dataIn == 2'b11) begin
              counterA <= counterA +2'd1;
              if(counterA == 2'd2 )begin
                    state <= 4'd3;
                    sosOutput <= 8'h6F;
                end else begin
                    state <= 4'd2;
                end
            end
        end
        4'd3:begin
            if (dataIn == 2'b10) begin
              state <= 4'd4;
            end else begin
              state <= 4'd0;
            end
        end
        4'd4:begin // OUT S
            if (dataIn == 2'b00) begin
                counterA <= counterA +2'd1;
                if(counterA == 2'd2 )begin
                    state <= 4'd0;
                    sosOutput <= 8'h73;
                end else begin
                    state <= 4'd4;
                end
            end
        end
        default: begin
        end
    endcase
      
    end else begin
      
    end
end

 //************ For Initializing Purpose  ***************//
always @(posedge clk)begin
    case(initialize)
        2'd0:begin
        end
        default:begin
            counterA<=2'b0;
            initialize <= 2'd0;
            sosOutput <= 8'h0;
            state <= 4'd0;
        end
    endcase
end
endmodule // 

//ME:
//iverilog sos_detector.v
//iverilog -o a.out sos_detector_tb.v
//vvp a.out
// open -a Scansion sos_detector_tb.vcd