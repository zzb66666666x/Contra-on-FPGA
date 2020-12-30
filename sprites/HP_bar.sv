module HP_bar(
	input logic Clk,
	input logic [4:0] player1_HP,
	input logic [4:0] player2_HP,
	input logic [9:0] player1_HP_start_x,
	input logic [9:0] player1_HP_start_y,	
	input logic [9:0] player2_HP_start_x,
	input logic [9:0] player2_HP_start_y,
	input logic [9:0] HP_bar_interval,
	input logic [9:0] DrawX, DrawY,
	output logic is_HP,
	output logic [3:0] HP_data
);

	logic [3:0] player1_HP1_data, player1_HP2_data, player1_HP3_data, player1_HP4_data, player1_HP5_data,
							 player2_HP1_data, player2_HP2_data, player2_HP3_data, player2_HP4_data, player2_HP5_data;
	logic is_player1_HP1, is_player1_HP2, is_player1_HP3, is_player1_HP4, is_player1_HP5,
			 is_player2_HP1, is_player2_HP2, is_player2_HP3, is_player2_HP4, is_player2_HP5;
			 
	logic player1_now, player2_now;
	logic [9:0] player1_first_HP_start_x, player1_second_HP_start_x, player1_third_HP_start_x, player1_fourth_HP_start_x, player1_fifth_HP_start_x, 
					player1_first_HP_start_y, player1_second_HP_start_y, player1_third_HP_start_y, player1_fourth_HP_start_y, player1_fifth_HP_start_y,
					player2_first_HP_start_x, player2_second_HP_start_x, player2_third_HP_start_x, player2_fourth_HP_start_x, player2_fifth_HP_start_x,
					player2_first_HP_start_y, player2_second_HP_start_y, player2_third_HP_start_y, player2_fourth_HP_start_y, player2_fifth_HP_start_y;
	
	assign player1_now = is_player1_HP1 || is_player1_HP2 || is_player1_HP3 || is_player1_HP4 || is_player1_HP5;
	assign player2_now = is_player2_HP1 || is_player2_HP2 || is_player2_HP3 || is_player2_HP4 || is_player2_HP5;

	assign player1_first_HP_start_x = player1_HP_start_x;
	assign player1_second_HP_start_x = player1_HP_start_x + 10'd20 + HP_bar_interval;
	assign player1_third_HP_start_x = player1_HP_start_x + 10'd2*(10'd20 + HP_bar_interval);
	assign player1_fourth_HP_start_x = player1_HP_start_x + 10'd3*(10'd20 + HP_bar_interval);
	assign player1_fifth_HP_start_x = player1_HP_start_x + 10'd4*(10'd20 + HP_bar_interval);
	
	assign player1_first_HP_start_y = player1_HP_start_y;
	assign player1_second_HP_start_y = player1_HP_start_y;
	assign player1_third_HP_start_y = player1_HP_start_y;
	assign player1_fourth_HP_start_y = player1_HP_start_y;
	assign player1_fifth_HP_start_y = player1_HP_start_y;

	assign player2_first_HP_start_x = player2_HP_start_x;
	assign player2_second_HP_start_x = player2_HP_start_x + 10'd20 + HP_bar_interval;
	assign player2_third_HP_start_x = player2_HP_start_x + 10'd2*(10'd20 + HP_bar_interval);
	assign player2_fourth_HP_start_x = player2_HP_start_x + 10'd3*(10'd20 + HP_bar_interval);
	assign player2_fifth_HP_start_x = player2_HP_start_x + 10'd4*(10'd20 + HP_bar_interval);
	
	assign player2_first_HP_start_y = player2_HP_start_y;
	assign player2_second_HP_start_y = player2_HP_start_y;
	assign player2_third_HP_start_y = player2_HP_start_y;
	assign player2_fourth_HP_start_y = player2_HP_start_y;
	assign player2_fifth_HP_start_y = player2_HP_start_y;

	
	range_checker_HP checker_player1_HP1 (
	   .Clk,
		.HP_status(player1_HP[4]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player1_first_HP_start_x), 
		.Pos_y(player1_first_HP_start_y), 
		.is_HP(is_player1_HP1),
		.HP_data(player1_HP1_data)
	);
	
	range_checker_HP checker_player1_HP2 (
	   .Clk,
		.HP_status(player1_HP[3]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player1_second_HP_start_x), 
		.Pos_y(player1_second_HP_start_y), 
		.is_HP(is_player1_HP2),
		.HP_data(player1_HP2_data)
	);

	range_checker_HP checker_player1_HP3 (
	   .Clk,
		.HP_status(player1_HP[2]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player1_third_HP_start_x), 
		.Pos_y(player1_third_HP_start_y), 
		.is_HP(is_player1_HP3),
		.HP_data(player1_HP3_data)
	);
	
	range_checker_HP checker_player1_HP4 (
	   .Clk,
		.HP_status(player1_HP[1]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player1_fourth_HP_start_x), 
		.Pos_y(player1_fourth_HP_start_y), 
		.is_HP(is_player1_HP4),
		.HP_data(player1_HP4_data)
	);
	
	range_checker_HP checker_player1_HP5 (
	   .Clk,
		.HP_status(player1_HP[0]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player1_fifth_HP_start_x), 
		.Pos_y(player1_fifth_HP_start_y), 
		.is_HP(is_player1_HP5),
		.HP_data(player1_HP5_data)
	);
	
	range_checker_HP checker_player2_HP1 (
	   .Clk,
		.HP_status(player2_HP[4]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player2_first_HP_start_x), 
		.Pos_y(player2_first_HP_start_y), 
		.is_HP(is_player2_HP1),
		.HP_data(player2_HP1_data)
	);
	
	range_checker_HP checker_player2_HP2 (
	   .Clk,
		.HP_status(player2_HP[3]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player2_second_HP_start_x), 
		.Pos_y(player2_second_HP_start_y), 
		.is_HP(is_player2_HP2),
		.HP_data(player2_HP2_data)
	);

	range_checker_HP checker_player2_HP3 (
	   .Clk,
		.HP_status(player2_HP[2]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player2_third_HP_start_x), 
		.Pos_y(player2_third_HP_start_y), 
		.is_HP(is_player2_HP3),
		.HP_data(player2_HP3_data)
	);
	
	range_checker_HP checker_player2_HP4 (
	   .Clk,
		.HP_status(player2_HP[1]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player2_fourth_HP_start_x), 
		.Pos_y(player2_fourth_HP_start_y), 
		.is_HP(is_player2_HP4),
		.HP_data(player2_HP4_data)
	);
	
	range_checker_HP checker_player2_HP5 (
	   .Clk,
		.HP_status(player2_HP[0]), 
		.DrawX(DrawX), 
		.DrawY(DrawY), 
		.Pos_x(player2_fifth_HP_start_x), 
		.Pos_y(player2_fifth_HP_start_y), 
		.is_HP(is_player2_HP5),
		.HP_data(player2_HP5_data)
	);
	
	always_comb begin
		if (player1_now) begin
			if (is_player1_HP1) begin
				is_HP = 1'b1;
				HP_data = player1_HP1_data;
			end
			else if(is_player1_HP2) begin
				is_HP = 1'b1;
				HP_data = player1_HP2_data;
			end
			else if(is_player1_HP3) begin
				is_HP = 1'b1;
				HP_data = player1_HP3_data;
			end
			else if(is_player1_HP4) begin
				is_HP = 1'b1;
				HP_data = player1_HP4_data;
			end
			else if(is_player1_HP5) begin
				is_HP = 1'b1;
				HP_data = player1_HP5_data;
			end
			else begin
				is_HP = 1'b0;
				HP_data = 4'd0;
			end
		end
		//
		else if (player2_now) begin
			if (is_player2_HP1) begin
				is_HP = 1'b1;
				HP_data = player2_HP1_data;
			end
			else if(is_player2_HP2) begin
				is_HP = 1'b1;
				HP_data = player2_HP2_data;
			end
			else if(is_player2_HP3) begin
				is_HP = 1'b1;
				HP_data = player2_HP3_data;
			end
			else if(is_player2_HP4) begin
				is_HP = 1'b1;
				HP_data = player2_HP4_data;
			end
			else if(is_player2_HP5) begin
				is_HP = 1'b1;
				HP_data = player2_HP5_data;
			end
			else begin
				is_HP = 1'b0;
				HP_data = 4'd0;
			end
		end
		//
		else begin
			is_HP = 1'b0;
			HP_data = 4'd0;
		end
	end
	
endmodule

module range_checker_HP(
	input logic Clk,
	input logic HP_status,
	input logic [9:0] DrawX, DrawY,
	input logic [9:0] Pos_x, Pos_y,
	output logic is_HP,
	output logic [3:0] HP_data
);

logic [9:0] size;
logic [8:0] read_address;
logic [9:0] candidate; 
logic [3:0] readdata;

always_comb begin
	is_HP = 1'b0;
	candidate = 10'd0;
	if (HP_status) begin
		if (DrawX >= Pos_x && DrawY >= Pos_y) 
		begin
			if ((DrawX - Pos_x <= size) && (DrawY - Pos_y <= size)) begin
				is_HP = 1'b1;
				candidate = DrawX - Pos_x + 10'd20*(DrawY - Pos_y);
			end
			else begin
 				is_HP = 1'b0;
				candidate = 10'd0;
			end
		end else begin
			is_HP = 1'b0;
			candidate = 10'd0;
		end
	end else begin
		is_HP = 1'b0;
		candidate = 10'd0;
	end
end

assign size = 10'd20;
assign read_address = (is_HP) ? candidate[8:0] : 9'd0;
assign HP_data = (is_HP) ? readdata : 4'd0;
HP_RAM HP_RAM_inst (.*, .HP_data(readdata));

endmodule


module  HP_RAM
(
		input [8:0] read_address,
		input Clk,

		output logic [3:0] HP_data
);

//400 = 20*20
logic [3:0] mem [0:399];// assume the size of the HP bar is 20*20
initial
begin
	 $readmemh("sprites/HP.txt", mem);
end

always_ff @ (posedge Clk) begin
	HP_data <= mem[read_address];
end

endmodule
