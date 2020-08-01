module moving(deal_key_up,deal_key_down,
deal_key_left,deal_key_right,clk,rst_n,
apple_x,apple_y,head_x,head_y,first_x,
first_y,is_exist);

input deal_key_down;
input deal_key_left;
input deal_key_right;
input deal_key_up;      //按键输入
input clk;                //时钟
input rst_n;              //复位

output reg[10:0]apple_x;
output reg[10:0]apple_y;//苹果
output [10:0]head_x;
output [10:0]head_y;//头
output [10:0]first_x;
output [10:0]first_y;//第一节身体
output reg[15:0]is_exist;//体长初始值为15'b0000_0000_0000_0111

reg [10:0]cube_x[15:0];
reg [10:0]cube_y[15:0];//蛇的坐标

wire end_game;//结束信号

reg hit_body;
reg hit_wall;//碰撞信息

reg[6:0]cube_num;//蛇的长度

localparam UP=2'b00;
localparam DOWN=2'b01;
localparam LEFT=2'b10;
localparam RIGHT=2'b11;//方向信息

wire [1:0]direct;
reg [1:0]direct_r;
reg [1:0]direct_next;//方向

reg [31:0]cnt;//计数器

reg change_to_left;
reg change_to_right;
reg change_to_up;
reg change_to_down;//方向变化

reg cube_add;//体长增加

reg [31:0]clk_cnt;
reg [10:0]random_num;//苹果计数器

reg addcube_state;//是否吃到苹果

assign head_x = cube_x[0];
assign head_y = cube_y[0];

assign first_x = cube_x[1];
assign first_y = cube_y[1];

assign end_game=hit_body|hit_wall;//死亡信号

assign direct=direct_r;//方向寄存

always @(posedge clk or negedge rst_n) //初始方向
begin		
	if(!rst_n)
		direct_r = RIGHT;
	else
		direct_r = direct_next;
end

always @(posedge clk or negedge rst_n) //初始化与运动算法
begin
	if(!rst_n) 
		begin
			cnt <= 0;
			hit_body<=0;
			hit_wall<=0;
			cube_x[0] <= 835;
			cube_y[0] <= 420;
					
			cube_x[1] <= 834;
			cube_y[1] <= 420;
					
			cube_x[2] <= 833;
			cube_y[2] <= 420;

			cube_x[3] <= 735;
			cube_y[3] <= 315;
					
			cube_x[4] <= 735;
			cube_y[4] <= 315;
					
			cube_x[5] <= 735;
			cube_y[5] <= 315;
					
			cube_x[6] <= 735;
			cube_y[6] <= 315;
					
			cube_x[7] <= 735;
			cube_y[7] <= 315;
					
			cube_x[8] <= 735;
			cube_y[8] <= 315;
					
			cube_x[9] <= 735;
			cube_y[9] <= 315;					
					
			cube_x[10] <= 735;
			cube_y[10] <= 315;
					
			cube_x[11] <= 735;
			cube_y[11] <= 315;
					
         cube_x[12] <= 735;
			cube_y[12] <= 315;
					
			cube_x[13] <= 735;
			cube_y[13] <= 315;
					
			cube_x[14] <= 735;
			cube_y[14] <= 315;
					
			cube_x[15] <= 735;
			cube_y[15] <= 315;
		end		
	else if (end_game)
	begin
			cnt <= 0;
								
			cube_x[0] <= 835;
			cube_y[0] <= 420;
					
			cube_x[1] <= 834;
			cube_y[1] <= 420;
					
			cube_x[2] <= 833;
			cube_y[2] <= 420;

			cube_x[3] <= 735;
			cube_y[3] <= 315;
					
			cube_x[4] <= 735;
			cube_y[4] <= 315;
					
			cube_x[5] <= 735;
			cube_y[5] <= 315;
					
			cube_x[6] <= 735;
			cube_y[6] <= 315;
					
			cube_x[7] <= 735;
			cube_y[7] <= 315;
					
			cube_x[8] <= 735;
			cube_y[8] <= 315;
					
			cube_x[9] <= 735;
			cube_y[9] <= 315;					
					
			cube_x[10] <= 735;
			cube_y[10] <= 315;
					
			cube_x[11] <= 735;
			cube_y[11] <= 315;
					
         cube_x[12] <= 735;
			cube_y[12] <= 315;
					
			cube_x[13] <= 735;
			cube_y[13] <= 315;
					
			cube_x[14] <= 735;
			cube_y[14] <= 315;
					
			cube_x[15] <= 735;
			cube_y[15] <= 315;//初始位置设置
		end
	else 
		begin
			cnt <= cnt + 1;
				begin
					if((direct == UP && cube_y[0] == 316)|(direct == DOWN && cube_y[0] == 764)|(direct == LEFT && cube_x[0] == 736)|(direct == RIGHT && cube_x[0] == 1184))
					   hit_wall <= 1;
					else if((cube_y[0] == cube_y[1] && cube_x[0] == cube_x[1] && is_exist[1] == 1)|
							(cube_y[0] == cube_y[2] && cube_x[0] == cube_x[2] && is_exist[2] == 1)|
							(cube_y[0] == cube_y[3] && cube_x[0] == cube_x[3] && is_exist[3] == 1)|
							(cube_y[0] == cube_y[4] && cube_x[0] == cube_x[4] && is_exist[4] == 1)|
							(cube_y[0] == cube_y[5] && cube_x[0] == cube_x[5] && is_exist[5] == 1)|
							(cube_y[0] == cube_y[6] && cube_x[0] == cube_x[6] && is_exist[6] == 1)|
							(cube_y[0] == cube_y[7] && cube_x[0] == cube_x[7] && is_exist[7] == 1)|
							(cube_y[0] == cube_y[8] && cube_x[0] == cube_x[8] && is_exist[8] == 1)|
							(cube_y[0] == cube_y[9] && cube_x[0] == cube_x[9] && is_exist[9] == 1)|
							(cube_y[0] == cube_y[10] && cube_x[0] == cube_x[10] && is_exist[10] == 1)|
							(cube_y[0] == cube_y[11] && cube_x[0] == cube_x[11] && is_exist[11] == 1)|
							(cube_y[0] == cube_y[12] && cube_x[0] == cube_x[12] && is_exist[12] == 1)|
							(cube_y[0] == cube_y[13] && cube_x[0] == cube_x[13] && is_exist[13] == 1)|
							(cube_y[0] == cube_y[14] && cube_x[0] == cube_x[14] && is_exist[14] == 1)|
							(cube_y[0] == cube_y[15] && cube_x[0] == cube_x[15] && is_exist[15] == 1))
							hit_body <= 1;//咬到自己
					else 
						begin
							cube_x[1] <= cube_x[0];
							cube_y[1] <= cube_y[0];
										
							cube_x[2] <= cube_x[1];
							cube_y[2] <= cube_y[1];
										
							cube_x[3] <= cube_x[2];
							cube_y[3] <= cube_y[2];
										
							cube_x[4] <= cube_x[3];
							cube_y[4] <= cube_y[3];
										
							cube_x[5] <= cube_x[4];
							cube_y[5] <= cube_y[4];
										
							cube_x[6] <= cube_x[5];
							cube_y[6] <= cube_y[5];
										
							cube_x[7] <= cube_x[6];
							cube_y[7] <= cube_y[6];
											
							cube_x[8] <= cube_x[7];
							cube_y[8] <= cube_y[7];
											
							cube_x[9] <= cube_x[8];
							cube_y[9] <= cube_y[8];
											
							cube_x[10] <= cube_x[9];
							cube_y[10] <= cube_y[9];
											
							cube_x[11] <= cube_x[10];
							cube_y[11] <= cube_y[10];
											
							cube_x[12] <= cube_x[11];
							cube_y[12] <= cube_y[11];
											 
							cube_x[13] <= cube_x[12];
							cube_y[13] <= cube_y[12];
											
							cube_x[14] <= cube_x[13];
							cube_y[14] <= cube_y[13];
											
							cube_x[15] <= cube_x[14];
							cube_y[15] <= cube_y[14];	//蛇的移动递进
							case(direct)							
								UP:begin
									 if(cube_y[0] == 316)
										hit_wall <= 1;
									else
										cube_y[0] <= cube_y[0]-1;
									end
									
								DOWN:	begin
									if(cube_y[0] == 764)
										hit_wall <= 1;
									else
										cube_y[0] <= cube_y[0] + 1;
										end
											
								LEFT: begin
									if(cube_x[0] == 736)
										hit_wall <= 1;
									else
										cube_x[0] <= cube_x[0] - 1;											
										end

								RIGHT:begin
									if(cube_x[0] == 1184)
										hit_wall <= 1;
											  else
										cube_x[0] <= cube_x[0] + 1;
										end
							endcase//蛇的移动与碰撞墙体
						end
				end
		end
end

always @(*) //方向控制
begin
		direct_next = direct;		
        case(direct)	
		    UP: begin
			    if(change_to_left)
				    direct_next = LEFT;
			    else if(change_to_right)
				    direct_next = RIGHT;
			    else
				    direct_next = UP;			
					end		
			
		    DOWN:begin
			    if(change_to_left)
				    direct_next = LEFT;
			    else if(change_to_right)
			        direct_next = RIGHT;
			    else
				    direct_next = DOWN;			
					end		
			
		    LEFT:begin
			    if(change_to_up)
				    direct_next = UP;
			    else if(change_to_down)
    			    direct_next = DOWN;
			    else
				    direct_next = LEFT;			
					end
		
		    RIGHT: begin
			    if(change_to_up)
				    direct_next = UP;
			    else if(change_to_down)
				    direct_next = DOWN;
			    else
				    direct_next = RIGHT;
						end	
	    endcase
end

always @(posedge clk) //按键控制
begin
	if(deal_key_left == 1)
		change_to_left <= 1;
	else if(deal_key_right == 1)
		change_to_right <= 1;
	else if(deal_key_up == 1)
		change_to_up <= 1;
	else if(deal_key_down == 1)
		change_to_down <= 1;
	else begin
		change_to_left <= 0;
		change_to_right <= 0;
		change_to_up <= 0;
		change_to_down <= 0;
		end
end


	
always@(posedge clk)//苹果产生
	random_num <= random_num + 999; 
always@(posedge clk or negedge rst_n) 

begin
	if(!rst_n) 
		begin
			clk_cnt <= 0;
			apple_x <= 800;
			apple_y <= 500;
			cube_add <= 0;
		end
	else 
		begin
			clk_cnt <= clk_cnt+1;
			if(clk_cnt == 250_000) 
				begin
					clk_cnt <= 0;
					if(apple_x == head_x && apple_y == head_y) 
						begin
							cube_add <= 1;
							apple_x <= {1'b0, (random_num[9:5] == 0 ? 800 : (random_num[9:4])+800)};
							apple_y <= (random_num[4:0] > 350) ? (random_num[4:0] - 100) : (random_num[4:0] == 0) ? 500:(random_num[4:0]+400);
						end//随机产生苹果
					else
						cube_add <= 0;
				end
		end
end

always @(posedge clk or negedge rst_n) //吃苹果与增长
begin	
		if(!rst_n) 
			begin
				is_exist <= 16'd7;
				cube_num <= 3;
				addcube_state <= 0;
			end  
		else begin			
			case(addcube_state)
				0:begin
					if(cube_add) 
						begin
							cube_num <= cube_num + 1;
							is_exist[cube_num] <= 1;
							addcube_state <= 1;
						end						
				end
				1: begin
					if(!cube_add)
						addcube_state <= 0;				
					end
			endcase
		end
end
	
endmodule