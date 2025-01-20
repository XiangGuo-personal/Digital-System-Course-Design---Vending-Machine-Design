
`timescale 1ns / 1ps
module key_filter4(
    input  clk,//ʱ���ź�
	input  rst,//��λ�ź�
	input  [5:0] btn,//����
	output reg[5:0] key_out            
);
reg start_cnt=0;//�Ƿ�ʼ����
reg [23:0]time_cnt=0;//������
reg [5:0]key_in=0;//�Ĵ�������
always@(posedge clk)
begin
     if(~rst)begin//��λ�Ļ��������жϹ�0�����ź�Ϊ0
       start_cnt<=0;
       key_out<=0;end
     else if(start_cnt)begin
        if(time_cnt==24'd9999999)begin//��������ﵽ2ms��,��ƽ����
           key_out<=btn;
           start_cnt<=0;//������0
           end
           else if(btn!=key_in)
           start_cnt<=0;
           else time_cnt<=time_cnt+1;
    end
     else if(btn!=key_out)//������ֵ��ԭ���β�ͬ���Ϳ�ʼ����
         begin
          start_cnt<=1;
          time_cnt<=0;
          key_in<=btn;
           end
     end

endmodule