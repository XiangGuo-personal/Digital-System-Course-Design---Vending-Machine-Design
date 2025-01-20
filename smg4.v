`timescale 1ns / 1ps
module smg4(
input clk,
input [3:0] smg7,smg6,smg5,smg4,smg3,smg2,smg1,smg0,//显示的密码
output reg[7:0] led_an,//使能
output reg[7:0] led_ca //亮灯
    );
reg [18:0] delay_time=0;
reg [3:0] display=0;//输出的字符

always@(posedge clk)
begin
    delay_time<=delay_time+1;
end

always@(posedge clk)  //延时
begin
case(delay_time[15:13])
3'b000:
begin
led_an<=8'b11111110;
display<=smg0;
end
3'b001:
begin
led_an<=8'b11111101;
display<=smg1;
end
3'b010:
begin
led_an<=8'b11111011;
display<=smg2;
end
3'b011:
begin
led_an<=8'b11110111;
display<=smg3;
end
 3'b100:
 begin
led_an<= 8'b11101111;
 display<=smg4;
 end
 
 3'b101:
 begin
 led_an<= 8'b11011111;
display<=smg5;
 end
 
 3'b110:
 begin
 led_an<= 8'b10111111;
 display<=smg6;
 end
 
 default:
 begin
 led_an<=8'b01111111;
 display<=smg7;
 end
 
endcase
end
always@(posedge clk)   //输出管脚设置
begin
case(display)
4'h0:led_ca[7:0]<=8'b11000000;//0
4'h1:led_ca[7:0]<=8'b11111001;//1
4'h2:led_ca[7:0]<=8'b10100100;//2
4'h3:led_ca[7:0]<=8'b10110000;//3
4'h4:led_ca[7:0]<=8'b10011001;//4
4'h5:led_ca[7:0]<=8'b10010010;//5
4'h6:led_ca[7:0]<=8'b10000010;//6
4'h7:led_ca[7:0]<=8'b11111000;//7
4'h8:led_ca[7:0]<=8'b10000000;//8
4'h9:led_ca[7:0]<=8'b10010000;//9
4'ha:led_ca[7:0]<=8'b10000000;//B
 4'hb: led_ca[7:0]<=8'b10000110;//E
 4'hc:led_ca[7:0]<=8'b11000010;//G
 4'hd:led_ca[7:0]<=8'b11111001;//I
 4'he: led_ca[7:0]<=8'b11001000;//N
default:led_ca[7:0]<=8'b11111111;
endcase
end


endmodule
