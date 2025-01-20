`timescale 1ns / 1ps
module light4 (
  input      wire      state1,state2,state3,state4,state5,state6,state7,//此时处于哪个状态
  input      wire      clk,// 50MHz
  input      wire      rst, // low valid
  output    reg    [3:0]    led1,
  output    reg    [1:0]  led2,led3,led4,led5,led6,led7   // high valid
) ;
 
  parameter    T_1s    = 50_000_000;   //4'b0001;//   
  
  reg          [25:0]  cnt;
  
  always @ (posedge clk, negedge rst) begin
  
    if (rst == 4'b0000)
      cnt <= 26'd0;
    else if (cnt < T_1s - 4'b0001)
        cnt <= cnt + 4'b0001;
    else
        cnt <= 26'b0;
  
  end
  
  always @ (posedge clk, negedge rst) begin
    led1 <= 4'b0001;
  led2 <= 2'b01;
  led3 <= 2'b01;
  led4 <= 2'b01;
  led5 <= 2'b01;
  led6 <= 2'b01;
  led7 <= 2'b01;
  if((state1==0)&&(state2==0)&&(state3==0)&&(state4==0)&&(state5==0)&&(state6==0)&&(state7==0))
  begin
  led1 <= 4'b0001;
  led2 <= 2'b01;
  led3 <= 2'b01;
  led4 <= 2'b01;
  led5 <= 2'b01;
  led6 <= 2'b01;
  led7 <= 2'b01;
  
  
  end
else if(state1==1)
  begin
      if (rst == 4'b0000)
        led1 <= 4'b0001;
      else if (cnt == T_1s - 4'b0001)
          led1 <= {led1[2:0], led1[3]};
        else
          led1 <= led1;
  end
  
 else if(state2==1)
begin
        if (rst == 4'b0000)
    led2 <= 2'b01;
  else if (cnt == T_1s - 4'b0001)
      led2 <= {led2[0], led2[1]};
    else
      led2 <= led2;
end

  
 else if(state3==1)
begin
       if (rst == 4'b0000)
   led3 <= 3'b01;
 else if (cnt == T_1s - 4'b0001)
     led3 <= {led3[0], led3[1]};
   else
     led3 <= led3;
end

  
 else if(state4==1)
begin
        if (rst == 4'b0000)
    led4 <= 2'b01;
  else if (cnt == T_1s - 4'b0001)
      led4 <= {led4[0], led4[1]};
    else
      led4 <= led4;
end

  
 else if(state5==1)
begin
        if (rst == 4'b0000)
    led5 <= 2'b01;
  else if (cnt == T_1s - 4'b0001)
      led5 <= {led5[0], led5[1]};
    else
      led5 <= led5;
end

  
 else if(state6==1)
begin
        if (rst == 4'b0000)
    led6 <= 2'b01;
  else if (cnt == T_1s - 4'b0001)
      led6 <= {led6[0], led6[1]};
    else
      led6 <= led6;
end

 else if(state7==1)
begin
        if (rst == 4'b0000)
    led7 <= 2'b01;
  else if (cnt == T_1s - 4'b0001)
      led7 <= {led7[0], led7[1]};
    else
      led7 <= led7;
end

 

end
endmodule
