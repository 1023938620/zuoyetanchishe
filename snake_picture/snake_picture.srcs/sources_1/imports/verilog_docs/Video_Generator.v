module Video_Generator(
 input  [3:0] key,
 input  rst,
 input clk_100MHz,
 input clk,
 input RGB_VDE,
 input [11:0]Set_X,
 input [11:0]Set_Y,

input [10:0] head_x,
input [10:0] head_y,
input [15:0] is_exist,
 output reg[23:0]RGB_Data=24'hffff00 //RBG
 );
 reg [17:0]Address=0;
 wire [7:0]R_Data;
 wire [7:0]G_Data;
 wire [7:0]B_Data;

 reg [10:0] cube_x_head ;
reg [10:0] cube_y_head ;
reg [15:0] cube_num ;


 //计数器
reg [27:0] cnt = 0;
reg         flag  =  0;

//reg         flag_left = 1;
//reg         flag_right = 1;
//reg         flag_down  = 1;
//reg         flag_up    = 1;


reg flag_1 = 0;

always@(posedge clk_100MHz)
if(flag_1 == 0 )
begin
        cube_x_head <= cube_x_head + 5;
end
else
     cube_x_head <= cube_x_head;


always @(posedge clk_100MHz or negedge rst)
begin
    if(!rst) begin
        cnt <= 0;
    end
    else begin
        if(cnt < 2500_0000 - 1) begin
          cnt <= cnt + 1;
        end    
        else
        begin
            cnt <= 0;
        end      
    end
end

always@(posedge clk_100MHz or negedge rst)
begin
    if(!rst)
        flag <= 0;
    else
    begin
        if(cnt == 2500_0000 - 1)
            flag <= ~flag;
        else
            flag <= flag;
    end
end
always@(posedge clk_100MHz or negedge rst)
begin
    if(!rst)
        flag_1 <= 0;
    else
    begin
        if(cnt == 2500_0000 - 1)
            flag_1 <= 0;
        else
            flag_1 <= 1;
    end
end

always@(*)
 begin
    if(Set_X>=710&&Set_X<1210)
    begin
        if(Set_Y >= 290 && Set_Y < 790)
        begin
            Address<=(Set_X-709)*500+(Set_Y-289);   //////////zhuyi

            if(Set_X >= cube_x_head - cube_num + 730  && Set_X < cube_x_head + 730)        // 自主运动目标起始位置
            begin
                if(Set_Y >= cube_y_head + 310  && Set_Y < cube_y_head + 310 + 8)         //8*8
                   RGB_Data <= 24'hfff000; 
                else
                    if(R_Data == 0)
                        RGB_Data <= 0;
                    else
                        RGB_Data <= 24'hffffff;
            end
            else 
                if(R_Data == 0)
                    RGB_Data <= 0;
                else
                    RGB_Data <= 24'hffffff;

        end
        else
            RGB_Data <= 24'hffffff;
        
    end
    else
        RGB_Data<=24'hffffff;
 end


 Picture_R_Rom R_ROM (
 .clka(clk), // input wire clka
 .ena(1), // input wire ena
 .addra(Address), // input wire [13 : 0] addra
 .douta(R_Data) // output wire [7 : 0] douta
 );
 Picture_G_Rom G_ROM (
 .clka(clk), // input wire clka
 .ena(1), // input wire ena
 .addra(Address), // input wire [13 : 0] addra
 .douta(G_Data) // output wire [7 : 0] douta
 );

 Picture_B_Rom B_ROM (
 .clka(clk), // input wire clka
 .ena(1), // input wire ena
 .addra(Address), // input wire [13 : 0] addra
 .douta(B_Data) // output wire [7 : 0] douta
 );

moving moving
(  
    .deal_key_down(key[0]),
    .deal_key_left(key[3]),
    .deal_key_right(key[2]),
    .deal_key_up  (key[1] ),
    .clk   (clk),
    .rst_n        (rst),
    .head_x  (head_x),
    .head_y  (head_y),
    .is_exist(is_exist)




);








endmodule




     