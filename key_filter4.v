
`timescale 1ns / 1ps
module key_filter4(
    input  clk,//时钟信号
	input  rst,//复位信号
	input  [5:0] btn,//按键
	output reg[5:0] key_out            
);
reg start_cnt=0;//是否开始计数
reg [23:0]time_cnt=0;//计数器
reg [5:0]key_in=0;//寄存器缓存
always@(posedge clk)
begin
     if(~rst)begin//复位的话，计数判断归0，新信号为0
       start_cnt<=0;
       key_out<=0;end
     else if(start_cnt)begin
        if(time_cnt==24'd9999999)begin//如果计数达到2ms后,电平拉高
           key_out<=btn;
           start_cnt<=0;//计数归0
           end
           else if(btn!=key_in)
           start_cnt<=0;
           else time_cnt<=time_cnt+1;
    end
     else if(btn!=key_out)//如果输出值和原波形不同，就开始计数
         begin
          start_cnt<=1;
          time_cnt<=0;
          key_in<=btn;
           end
     end

endmodule