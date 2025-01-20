`timescale 1ns / 1ps
module huizong(
  input clk,
  input rst,
  input [5:0]btn,
  output wire [7:0]led_an,//使能端
  output wire[7:0]led_ca,//数码管管脚
  output wire[3:0]led1,
  output wire[1:0]led2,
  output wire[1:0]led3,
  output wire[1:0]led4,
  output wire[1:0]led5,
  output wire[1:0]led6,
  output wire[1:0]led7
 );
  wire[5:0] key;
  reg[9:0]m=0;//投币总额   
  reg[3:0]dj11,dj12,dj13,dj14,dj21,dj22,dj23,dj24,dj31,dj32,dj33,dj34,dj41,dj42,dj43,dj44;
  reg [2:0] state;//系统状态
  reg statefu1,statefu2,statefu3,statefu4,statefu5,statefu6,statefu7;
   
  reg [5:0] key_before;
  reg [5:0] key_pressed;//五个按钮
  reg [3:0]smg7,smg6,smg5,smg4,smg3,smg2,smg1,smg0;//数码管即将显示的数字
  reg[3:0]cnt11,cnt12,cnt13,cnt14,cnt21,cnt22,cnt23,cnt24,cnt31,cnt32,cnt33,cnt34,cnt41,cnt42,cnt43,cnt44;//存储数量
  reg[3:0]cnt_buy1,cnt_buy2;//第一次购买商品数量，第二次购买商品数量
  reg[9:0]money1,money2,money3,type1,type2;//第一次总价，第二次总价，总价，种类一，种类二 
  reg[9:0]money_toubi=0,money_zhaoling=0;//投币总额，找零总额
   smg4 my_smg4(
   .clk(clk),
   .smg7(smg7),
   .smg6(smg6),
   .smg5(smg5),
   .smg4(smg4),
   .smg3(smg3),
   .smg2(smg2),
   .smg1(smg1),
   .smg0(smg0),
   .led_an(led_an),
   .led_ca(led_ca)
   );
    light4 my_light4 (
      .led1(led1),
      .led2(led2),
      .led3(led3),
      .led4(led4),
      .led5(led5),
      .led6(led6),
      .led7(led7),
      .clk(clk),// 50MHz
      .rst(rst), // low valid
      .state1(statefu1),
      .state2(statefu2),
      .state3(statefu3),
      .state4(statefu4),
      .state5(statefu5),
      .state6(statefu6),
      .state7(statefu7)
      
    ) ;
   key_filter4 my_key_filter4(
    .clk(clk),
    .rst(rst),
    .btn(btn),
    .key_out(key)
   );
 always@(posedge clk)
 begin
   key_before<=key;
 if(key_before[0]==0&&key[0]==1)
      key_pressed[0]<=1;
      else begin key_pressed[0]<=0;
      end
 if(key_before[1]==0&&key[1]==1)
           key_pressed[1]<=1;
           else begin key_pressed[1]<=0;
           end
 if(key_before[2]==0&&key[2]==1)
           key_pressed[2]<=1;
           else begin key_pressed[2]<=0;
           end
 if(key_before[3]==0&&key[3]==1)
           key_pressed[3]<=1;
           else begin key_pressed[3]<=0;
            end
 if(key_before[4]==0&&key[4]==1)
            key_pressed[4]<=1;
            else begin key_pressed[4]<=0;
            end
 if(key_before[5]==0&&key[5]==1)
            key_pressed[5]<=1;
            else begin key_pressed[5]<=0;
  end
 end   //按键按下检测   
always@(posedge clk)begin
          dj11<=4'd3;
          dj12<=4'd4;
          dj13<=4'd6;
          dj14<=4'd3;
          dj21<=4'd10;
          dj22<=4'd8;
          dj23<=4'd9;
          dj24<=4'd7;
          dj31<=4'd4;
          dj32<=4'd6;
          dj33<= 4'd15;
          dj34<=4'd8;
          dj41<=4'd9;
          dj42<=4'd4;
          dj43<=4'd5;
          dj44<=4'd5;
case(state)
3'b000:begin
       statefu1=1;
       statefu2=0;
       statefu3=0;
       statefu4=0;
       statefu5=0;
       statefu6=0;
       statefu7=0;

         money_toubi<=0;
         cnt11<=9;//初始储量均为9
         cnt12<=9;
         cnt13<=9;
         cnt14<=9;
         cnt21<=9;
         cnt22<=9;
         cnt23<=9;
         cnt24<=9;
         cnt31<=9;
         cnt32<=9;
         cnt33<=9;
         cnt34<=9;
          smg7 <= 4'hf;
          smg6 <= 4'hf;
          smg5 <= 4'hf;
          smg4 <= 4'ha;
          smg3 <= 4'hb;//数码管显示1
          smg2 <= 4'hc;//数码管显示1
          smg1 <= 4'hd;
          smg0 <= 4'he;
          if(!rst)begin
             state=3'b000;
                 end
else  if(key_pressed[0])//如果按下确认键
           begin
           smg7 <= 4'hf;
           smg6 <= 4'hf;
           smg5 <= 4'hf;
           smg4 <= 4'hf;
           smg3 <= 4'h1;//数码管显示1
           smg2 <= 4'h1;//数码管显示1
           smg1 <= 4'hf;
           smg0 <= 4'hf;
           state<=3'b001;
           end
           end
3'b001:
begin
statefu1=0;
statefu2=1;
statefu3=0;
statefu4=0;
statefu5=0;
statefu6=0;
statefu7=0;
          if(smg0==0)
           begin
           smg3<=4'h1;
           smg2<=4'h1;
           smg1<=4'hf;
           smg0<=4'hf;
           end
       else if(!rst)
          state<=3'b000;
       else if(key_pressed[3])//行加
          begin
          if(smg3==4'h4)
            begin
             smg3<=4'h1;
             end
            else begin
             smg3<=smg3+4'h1;
             end
            end
       else if(key_pressed[1])//列加
           begin
             if(smg2==4'h4)
             begin
             smg2<=4'h1;
             end
             else begin
             smg2<=smg2+4'h1;
             end
            end
      else if(key_pressed[0])
           begin
            case(smg3)
             4'h1:if(smg2==4'h1)begin
                     smg1<=cnt11;
                       if(cnt11==0)begin
                       state<=3'b001;
                       smg0<=4'h0;end
                        else begin
                       state<=3'b010;
                       smg0<=4'h1;
                       end end
                  else if(smg2==4'h2)begin
                  smg1<=cnt12; 
                  if(cnt12==0)begin
                  state<=3'b001; smg0<=4'h0;end
                  else begin
                  state<=3'b010; smg0<=4'h1;end end
                  else if(smg2==4'h3)begin
                  smg1<=cnt13;
                  if(cnt13==0)begin
                  state<=3'b001; smg0<=4'h0;end
                  else begin
                  state<=3'b010; smg0<=4'h1;end end
                  else if(smg2==4'h4)begin
                  smg1<=cnt14;
                  if(cnt14==0)begin
                  state<=3'b001; smg0<=4'h0;end
                  else begin
                  state<=3'b010; smg0<=4'h1;end end
            4'h2:if(smg2==4'h1)begin
                  smg1<=cnt21;
                       if(cnt21==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h2)begin
                  smg1<=cnt22;
                    if(cnt22==0)begin
                                   smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h3)begin
                  smg1<=cnt23;
                  if(cnt23==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h4)begin
                  smg1<=cnt24;
                  if(cnt24==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
            4'h3:if(smg2==4'h1)begin
                  smg1<=cnt31;
                  if(cnt31==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h2)begin
                  smg1<=cnt32;
                  if(cnt32==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h3)begin
                  smg1<=cnt33;
                  if(cnt33==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h4)begin
                  smg1<=cnt34;
                  if(cnt34==0)begin
                                     smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
           4'h4:if(smg2==4'h1)begin
                  smg1<=cnt41;
                  if(cnt41==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h2)begin
                  smg1<=cnt42;
                  if(cnt42==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h3)begin
                  smg1<=cnt43;
                  if(cnt43==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;end
                                    else begin
                                     smg0<=4'h1;
                                    state<=3'b010;end end
                  else if(smg2==4'h4)begin
                  smg1<=cnt44;
                  if(cnt44==0)begin
                                    smg0<=4'h0;
                                    state<=3'b001;
                                    end
                                    else begin
                                    smg0<=4'h1;
                                    state<=3'b010;end end
            endcase
          end
        end
    3'b010://第一次选择数量，数码管显示
    begin
statefu1=0;
statefu2=0;
statefu3=1;
statefu4=0;
statefu5=0;
statefu6=0;
statefu7=0;
             if(!rst)
             state<=3'b000;
 
              else if(key_pressed[3])//数量加
              begin
              if(smg1>=3)begin
                 if(smg0==1)begin
                    smg0<=2;end
                 else if(smg0==2)begin
                    smg0<=3;end
                 else if(smg0==3)begin
                    smg0<=1;end
                  end
              else if(smg1==2)begin
                  if(smg0==1)begin
                     smg0<=2;end
                  if(smg0==2)begin
                     smg0<=1;end end
               else if(smg1==1)begin
                  smg0<=1;end
               end
              else if(key_pressed[4])//数量减
              begin
                   if(smg1>=3)begin
                          if(smg0==1)begin
                             smg0<=3;end
                          else if(smg0==2)begin
                             smg0<=1;end
                          else if(smg0==3)begin
                             smg0<=2;end
                            end
                   else if(smg1==2)begin
                          if(smg0==1)begin
                              smg0<=2;end
                          if(smg0==2)begin
                              smg0<=1;end end
                   else  if(smg1==1)begin
                               smg0<=1;end
                  end
             else if(key_pressed[0])begin//确认
                  case(smg3)
                      4'h1:if(smg2==1)begin
                              cnt11<=cnt11-smg0;
                              state<=3'b011;
                              money1<=dj11*smg0;
                              end
                             else if(smg2==2)begin   
                               cnt12<=cnt12-smg0;
                               state<=3'b011;
                               money1<=dj12*smg0;
                             end
                              else if(smg2==3)begin
                              cnt13<=cnt13-smg0;
                              state<=3'b011;
                               money1<=dj13*smg0;end
                              else if(smg2==4)begin  
                              cnt14<=cnt14-smg0;
                              state<=3'b011;
                               money1<=dj14*smg0;end
                      4'h2:if(smg2==1)begin
                             cnt21<=cnt21-smg0;
                             state<=3'b011;
                              money1<=dj21*smg0;end
                             else if(smg2==2) begin  
                             cnt22<=cnt22-smg0;
                             state<=3'b011;
                              money1<=dj22*smg0;end
                             else if(smg2==3)begin
                             state<=3'b011;
                             cnt23<=cnt23-smg0;
                              money1<=dj23*smg0;end
                             else if(smg2==4)begin   
                             cnt24<=cnt24-smg0;
                             state<=3'b011; 
                              money1<=dj24*smg0; end
                       4'h3:if(smg2==1) begin
                             cnt31<=cnt31-smg0;
                             state<=3'b011;
                              money1<=dj31*smg0;end
                             else if(smg2==2)begin
                             cnt32<=cnt32-smg0;
                             state<=3'b011;
                              money1<=dj32*smg0;end
                             else if(smg2==3)begin
                             state<=3'b011;
                             cnt33<=cnt33-smg0;
                              money1<=dj33*smg0;end
                             else if(smg2==4) begin
                             state<=3'b011;
                             cnt34<=cnt34-smg0;
                              money1<=dj34*smg0;end
                       4'h4:if(smg2==1)begin
                             cnt41<=cnt41-smg0;
                             state<=3'b011;
                              money1<=dj41*smg0;end
                             else if(smg2==2)begin   
                             cnt42<=cnt42-smg0;
                             state<=3'b011;
                              money1<=dj42*smg0;end
                             else if(smg2==3)begin
                             cnt43<=cnt43-smg0;
                             state<=3'b011;
                              money1<=dj43*smg0;end
                             else if(smg2==4)begin   
                             cnt44<=cnt44-smg0;
                             state<=3'b011; 
                              money1<=dj44*smg0;end                                 
                  endcase
                  smg7<=4'h1;
                  smg6<=4'h1;
                  smg5<=4'hf;
                  smg4<=4'hf;
                  type1=smg3*10+smg2;
              end
          else if(key_pressed[2])//跳过键
          begin
               case(smg3)
                        4'h1:if(smg2==1)begin
                                cnt11<=cnt11-smg0;
                                state<=3'b101;
                                money1<=dj11*smg0;
                                end
                               else if(smg2==2)begin   
                                 cnt12<=cnt12-smg0;
                                 state<=3'b101;
                                 money1<=dj12*smg0;
                               end
                                else if(smg2==3)begin
                                cnt13<=cnt13-smg0;
                                state<=3'b101;
                                 money1<=dj13*smg0;
                                 money2<=0;
                                type2<=0;end
                                else if(smg2==4)begin  
                                cnt14<=cnt14-smg0;
                                state<=3'b101;
                                 money1<=dj14*smg0;
                               end
                        4'h2:if(smg2==1)begin
                               cnt21<=cnt21-smg0;
                               state<=3'b101;
                                money1<=dj21*smg0;end
                               else if(smg2==2) begin  
                               cnt22<=cnt22-smg0;
                               state<=3'b101;
                                money1<=dj22*smg0;end
                               else if(smg2==3)begin
                               state<=3'b101;
                               cnt23<=cnt23-smg0;
                                money1<=dj23*smg0;end
                               else if(smg2==4)begin   
                               cnt24<=cnt24-smg0;
                               state<=3'b101;
                                money1<=dj24*smg0; end
                         4'h3:if(smg2==1) begin
                               cnt31<=cnt31-smg0;
                               state<=3'b101;
                                money1<=dj31*smg0;end
                               else if(smg2==2)begin
                               cnt32<=cnt32-smg0;
                               state<=3'b101;
                                money1<=dj32*smg0;end
                               else if(smg2==3)begin
                               state<=3'b101;
                               cnt33<=cnt33-smg0;
                                money1<=dj33*smg0;end
                               else if(smg2==4) begin
                               state<=3'b101;  
                               cnt34<=cnt34-smg0;
                                money1<=dj34*smg0;end
                         4'h4:if(smg2==1)begin
                               cnt41<=cnt41-smg0;
                               state<=3'b101;
                                money1<=dj41*smg0;end
                               else if(smg2==2)begin   
                               cnt42<=cnt42-smg0;
                               state<=3'b101;
                                money1<=dj42*smg0;end
                               else if(smg2==3)begin
                               cnt43<=cnt43-smg0;
                               state<=3'b101;
                                money1<=dj43*smg0;end
                               else if(smg2==4)begin   
                               cnt44<=cnt44-smg0;
                               state<=3'b101;
                                money1<=dj44*smg0;end                                 
                    endcase
                    smg7<=4'hf;
                    smg6<=4'hf;
                    smg5<=4'hf;
                    smg4<=4'hf;
                    type1=smg3*10+smg2;
                    money2<=0;
                    type2<=0;
              end
              end
              3'b011:
              begin
                         statefu1=0;
   statefu2=0;
   statefu3=0;
   statefu4=1;
   statefu5=0;
   statefu6=0;
   statefu7=0;
               if(smg4==0)
                          begin
                          smg7<=4'h1;
                          smg6<=4'h1;
                          smg5<=4'hf;
                          smg4<=4'hf;
                           end
              else if(!rst)//第二次选择货物
                       state<=3'b000;
              else if(key_pressed[3])//行加
                                 begin
                                 if(smg7==4'h4)//左边四个数码管
                                   begin
                                    smg7<=4'h1;
                                    end
                                   else begin
                                    smg7<=smg7+4'h1;
                                    end
                                   end
                      else if(key_pressed[1])//列加
                                  begin
                                    if(smg6==4'h4)
                                    begin
                                    smg6<=4'h1;
                                    end
                                    else begin
                                    smg6<=smg6+4'h1;
                                    end
                                   end
                      else if(key_pressed[0])//确认键
                                  begin
                              case(smg7)//按下确认键后显示第二次所选货物
                                   4'h1:if(smg6==4'h1)begin
                                     smg5<=cnt11;
                                                if(cnt11==0)begin
                                                state<=3'b011;
                                                smg4<=4'h0;end
                                          else begin
                                                   state<=3'b100;
                                                    smg4<=4'h1;
                                                 end 
                                           end
                                         else if(smg6==4'h2)begin
                                         smg5<=cnt12;
                                         if(cnt12==0)begin
                                         state<=3'b011; smg4<=4'h0;end
                                         else begin
                                         state<=3'b100; smg4<=4'h1;end end
                                         else if(smg6==4'h3)begin
                                         smg5<=cnt13;
                                         if(cnt13==0)begin
                                         state<=3'b011; smg4<=4'h0;end
                                         else begin
                                         state<=3'b100; smg4<=4'h1;end end
                                         else if(smg6==4'h4)begin
                                         smg5<=cnt14;
                                         if(cnt14==0)begin
                                         state<=3'b011; smg4<=4'h0;end
                                         else begin
                                         state<=3'b100; smg4<=4'h1;end end
                                   4'h2:if(smg6==4'h1)begin
                                         smg5<=cnt21;
                                              if(cnt21==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h2)begin
                                         smg5<=cnt22;
                                           if(cnt22==0)begin
                                                          smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h3)begin
                                         smg5<=cnt23;
                                         if(cnt23==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b110;end end
                                         else if(smg6==4'h4)begin
                                         smg5<=cnt24;
                                         if(cnt24==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                   4'h3:if(smg6==4'h1)begin
                                         smg5<=cnt31;
                                         if(cnt31==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h2)begin
                                         smg5<=cnt32;
                                         if(cnt32==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h3)begin
                                         smg5<=cnt33;
                                         if(cnt33==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h4)begin
                                         smg5<=cnt34;
                                         if(cnt34==0)begin
                                                            smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                  4'h4:if(smg6==4'h1)begin
                                         smg5<=cnt41;
                                         if(cnt41==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h2)begin
                                         smg5<=cnt42;
                                         if(cnt42==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h3)begin
                                         smg5<=cnt43;
                                         if(cnt43==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                            smg4<=4'h1;
                                                           state<=3'b100;end end
                                         else if(smg6==4'h4)begin
                                         smg5<=cnt44;
                                         if(cnt44==0)begin
                                                           smg4<=4'h0;
                                                           state<=3'b011;end
                                                           else begin
                                                           smg4<=4'h1;
                                                           state<=3'b100;end end
                                   
                                endcase
                             end
            end            
              3'b100:
                    begin
                               statefu1=0;
         statefu2=0;
         statefu3=0;
         statefu4=0;
         statefu5=1;
         statefu6=0;
         statefu7=0;
                      if(!rst)
                      state<=3'b000;
                      if(key_pressed[3])
                       begin
                            if(smg5>=3)
                              begin
                              if(smg4==3)
                                 smg4<=4'h1;
                              else
                              smg4<=smg4+4'h1;
                              end
                            else if(smg5==2)begin
                              if(smg4==1)
                               smg4<=2;
                               if(smg4==2)
                               smg4<=1;end
                            else if(smg5==1)begin
                               smg4<=1;
                             end
                     end
                     else if(key_pressed[4])
                     begin
                          if(smg5>=3)
                                     begin
                                     if(smg4==1)
                                        smg4<=4'h3;
                                     else
                                     smg4<=smg4-4'h1;
                                     end
                         else if(smg5==2)begin
                                     if(smg4==1)
                                      smg4<=2;
                                      if(smg4==2)
                                      smg4<=1;end
                        else if(smg5==1)begin
                                      smg4<=1;
                                    end
                        end       
                   else if(key_pressed[0])
                   begin
                        case(smg7)
                        4'h1:if(smg6==1)begin//1行1列，计算第二次价格
                             cnt11<=cnt11-smg4;
                             state<=3'b101;
                             money2<=dj11*smg4;
                             end
                             else if(smg6==2)begin//1行2列，计算第二次价格
                             cnt12<=cnt12-smg4;
                             state<=3'b101;
                             money2<=dj12*smg4; end
                              else if(smg6==3)begin//1行3列，计算第二次价格
                              cnt13<=cnt13-smg4;
                              state<=3'b101;
                              money2<=dj13*smg4; end
                               else if(smg6==4)begin//1行4列，计算第二次价格
                              cnt14<=cnt14-smg4;
                              state<=3'b101;
                             money2<=dj14*smg4; end 
                                  
                     4'h2:if(smg6==1)begin//2行1列，计算第二次价格
                                            cnt21<=cnt21-smg4;
                                            state<=3'b101;
                                            money2<=dj21*smg4;
                                            end
                                            else if(smg6==2)begin//1行2列，计算第二次价格
                                            cnt22<=cnt22-smg4;
                                            state<=3'b101;
                                            money2<=dj22*smg4; end
                                             else if(smg6==3)begin//1行2列，计算第二次价格
                                             cnt23<=cnt23-smg4;
                                             state<=3'b101;
                                              money2<=dj23*smg4; end
                                              else if(smg6==4)begin//1行4列，计算第二次价格
                                             cnt24<=cnt24-smg4;
                                             state<=3'b101;
                                            money2<=dj24*smg4; end           
                      4'h3:if(smg6==1)begin//2行1列，计算第二次价格
                                 cnt31<=cnt31-smg4;
                                 state<=3'b101;
                                 money2<=dj31*smg4;
                                 end
                                 else if(smg6==2)begin//1行2列，计算第二次价格
                                 cnt32<=cnt32-smg4;
                                 state<=3'b101;
                                 money2<=dj32*smg4; end
                                 else if(smg6==3)begin//1行2列，计算第二次价格
                                 cnt33<=cnt33-smg4;
                                 state<=3'b101;
                                 money2<=dj33*smg4; end    
                                 else if(smg6==4)begin//1行4列，计算第二次价格
                                 cnt34<=cnt34-smg4;
                                 state<=3'b101;
                                 money2<=dj34*smg4; end
                      4'h4:if(smg6==1)begin//2行1列，计算第二次价格
                           cnt41<=cnt41-smg4;
                           state<=3'b101;
                           money2<=dj41*smg4;
                           end
                           else if(smg6==2)begin//1行2列，计算第二次价格
                           cnt42<=cnt42-smg4;
                            state<=3'b101;
                           money2<=dj42*smg4; end
                           else if(smg6==3)begin//1行2列，计算第二次价格
                           cnt43<=cnt43-smg4;
                           state<=3'b101;
                           money2<=dj43*smg4; end    
                           else if(smg6==4)begin//1行4列，计算第二次价格
                            cnt44<=cnt44-smg4;
                           state<=3'b101;
                            money2<=dj44*smg4; end
              
                       default:
                            money2<=dj11*smg4; 
                       endcase
                           type2 = smg7*10+smg6;//第二次选择种类
                       end
                   end 
               3'b101:begin//投币状态
                          statefu1=0;
    statefu2=0;
    statefu3=0;
    statefu4=0;
    statefu5=0;
    statefu6=1;
    statefu7=0;
                      money3 <= money1+ money2;
                      smg7<=money_toubi/9'd10;
                      smg6<=money_toubi%9'd10;
                      smg5<=money_zhaoling/9'd10;
                      smg4<=money_zhaoling%9'd10;
                      smg3<=4'hf;
                      smg2<=4'hf;
                      smg1<= money3/9'd10;//分别给数码管1,0赋值
                      smg0<= money3%9'd10;
              
                      if(key_pressed[0])
                      begin
                          money_toubi<=9'd1+money_toubi;
                      end
                      else if(key_pressed[1])
                      begin
                          money_toubi<=9'd5+money_toubi;
                      end
                          else if(key_pressed[2])
                      begin
                          money_toubi<=9'd10+money_toubi; 
                      end
                          else if(key_pressed[3])
                      begin
                          money_toubi<=9'd20+money_toubi;
                      end
                          else if(key_pressed[4])
                      begin
                          money_toubi<=9'd50+money_toubi;
                      end
                      else
                      begin
                          money_toubi<=0+money_toubi;
                      end
                      m<=money_toubi;//m会随着找零减一 money_toubi始终是总投币
                      
                //按下取消键or确认键进入110退币状态
                         if(!rst)//取消键 此时找零金额为投币总金额
                         begin
                         money_zhaoling<=m;
                         smg3<=4'h0;
                         smg2<=4'h0;
                         case(type1)
                         10'd11:cnt11=cnt11+cnt_buy1;
                         10'd12:cnt12=cnt12+cnt_buy1;
                         10'd13:cnt13=cnt13+cnt_buy1;
                         10'd14:cnt14=cnt14+cnt_buy1;
                         10'd21:cnt21=cnt21+cnt_buy1;
                         10'd22:cnt22=cnt22+cnt_buy1;
                         10'd23:cnt23=cnt23+cnt_buy1;
                         10'd24:cnt24=cnt24+cnt_buy1;
                         10'd31:cnt31=cnt31+cnt_buy1;
                         10'd32:cnt32=cnt32+cnt_buy1;
                         10'd33:cnt33=cnt33+cnt_buy1;
                         10'd34:cnt34=cnt34+cnt_buy1;
                         10'd41:cnt41=cnt41+cnt_buy1;
                         10'd42:cnt42=cnt42+cnt_buy1;
                         10'd43:cnt43=cnt43+cnt_buy1;
                         10'd44:cnt44=cnt44+cnt_buy1;
                         endcase
                         case(type2)
                         10'd11:cnt11=cnt11+cnt_buy2;
                         10'd12:cnt12=cnt12+cnt_buy2;
                         10'd13:cnt13=cnt13+cnt_buy2;
                         10'd14:cnt14=cnt14+cnt_buy2;
                         10'd21:cnt21=cnt21+cnt_buy2;
                         10'd22:cnt22=cnt22+cnt_buy2;
                         10'd23:cnt23=cnt23+cnt_buy2;
                         10'd24:cnt24=cnt24+cnt_buy2;
                         10'd31:cnt31=cnt31+cnt_buy2;
                         10'd32:cnt32=cnt32+cnt_buy2;
                         10'd33:cnt33=cnt33+cnt_buy2;
                         10'd34:cnt34=cnt34+cnt_buy2;
                         10'd41:cnt41=cnt41+cnt_buy2;
                         10'd42:cnt42=cnt42+cnt_buy2;
                         10'd43:cnt43=cnt43+cnt_buy2;
                         10'd44:cnt44=cnt44+cnt_buy2;
                         endcase
              
                         state<=3'b110;
                         end
                         else if(key_pressed[5])//确认键 此时找零金额为投币总金额减商品总额
                         begin
                         money_zhaoling<=m-money3;
                         smg3<=4'h0;
                         smg2<=4'h1;
                         state<=3'b110;
                         end
                         else
                         begin
                         money_zhaoling<=0;
                         end
                             
               end
               
                3'b110:begin 
                           statefu1=0;
     statefu2=0;
     statefu3=0;
     statefu4=0;
     statefu5=0;
     statefu6=0;
     statefu7=1;   
              //找零状态，按下一次手动找零键key_pressed[3],,money_zhaoling减一，直到money_zhaoling=0 
                  if(money_zhaoling&&key_pressed[3])
                  begin
                      money_zhaoling<=money_zhaoling-1;
                  end
                  else if(key_pressed[0])
                  begin
                     state<=3'b000;
                  end
              
                  else
                  begin
                  money_zhaoling<=money_zhaoling;
                  end
                  smg5<=money_zhaoling/9'd10;
                  smg4<=money_zhaoling%9'd10;
              
              end
    endcase 
end
                     
endmodule





