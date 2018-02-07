module dash_dot ( input clk,input dataIn ,output valueReady, output[1:0]dataOut
  
);
reg[1:0] dataOut;
reg valueReady;
reg [3:0] state;

wire clk;

always @(posedge clk ) begin
case (state)
  4'd0:begin
    valueReady <= 1'b0;
    if (dataIn == 1'b1) begin
      state <= 4'd3; //state <= 3'd1;
    end
    else if(dataIn == 1'b0)begin
      state <= 4'd2;
    end
  end
  4'd1:begin
    valueReady <= 1'b0; // newEd
    if (dataIn == 1'b1) begin
      state <= 4'd5;
    end else if(dataIn == 1'b0) begin
      state <= 4'd7; // newEd 4'd2
    end
  end
  4'd2:begin
  valueReady <= 1'b0;
  if (dataIn == 1'b1) begin
      state <= 4'd3;
  end else if(dataIn == 1'b0) begin
      state <= 4'd4;
    end
  end
  4'd3:begin // ******* outPut Dots ********
    if (dataIn == 1'b1) begin
      valueReady <= 1'b0;
      state <= 3'd2; // edit new
    end else if(dataIn == 1'b0) begin
      state <= 4'd0;
      valueReady <= 1'b1;
      dataOut <= 00;
    end
    
  end
  4'd4:begin // ******* outPut Space ********
    valueReady <= 1'b1;
    dataOut <= 10;
    if (dataIn == 1'b1) begin
      state <= 4'd1;
    end else if(dataIn == 1'b0) begin
      state <= 4'd0;
    end
  end
  4'd5:begin
    if (dataIn == 1'b1) begin
      state <= 4'd6;
    end else if(dataIn == 1'b0) begin
      state <= 4'd0;
    end
  end
  4'd6:begin  // ******* outPut Dash ********
    state <= 4'd1;
    valueReady <= 1'b1;
    dataOut <= 2'b11;
  end
  4'd7:begin
    if(dataIn == 1'b0)begin
      state <= 4'd8;
    end else if(dataIn == 1'b1) begin
      state <= 3'd5;
    end
  end
  4'd8:begin
    if(dataIn == 1'b0)begin // ******* outPut Space ********
      state <= 4'd2;
      valueReady <= 1'b1;
      dataOut <= 2'b10;
    end
  end

  default:begin
    state <= 4'd0;
    valueReady <= 1'b0;
    dataOut <= 01;
  end
endcase

end
endmodule // 

//ME:
//iverilog sos_detector.v
//iverilog -o a.out sos_detector_tb.v
//vvp a.out
// open -a Scansion sos_detector_tb.vcd