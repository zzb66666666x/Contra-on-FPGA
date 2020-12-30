module player1(
	input logic Clk,
	input logic show_player1,
	input logic [9:0] player1_pos_x,
	input logic [9:0] player1_pos_y,
	input logic [3:0] player1_current_image,
	input logic player1_face_dir,
	input logic [9:0] DrawX, DrawY,
	output logic [3:0] player1_data,
	output is_player1
);

logic [9:0] image_upper_left_x [0:5];
logic [9:0] image_upper_left_y [0:5];
logic [14:0] addr_candidate, read_address;
logic [3:0] readdata;
logic [9:0] current_corner_x, current_corner_y, real_pixel_x, real_pixel_y;
//offset to body center (+20, +25)
logic [9:0] source_image_size_x;
logic [9:0] source_image_size_y;
logic [9:0] single_image_size_x;
logic [9:0] single_image_size_y;
logic [9:0] face_dir_offset_x;

assign source_image_size_x = 10'd120;
assign source_image_size_y = 10'd150;
assign single_image_size_x = 10'd30;
assign single_image_size_y = 10'd50;
assign face_dir_offset_x = 10'd30;
assign image_upper_left_x = '{10'd0, 10'd0, 10'd0, 10'd60, 10'd60, 10'd60};
assign image_upper_left_y = '{10'd0, 10'd50, 10'd100, 10'd0, 10'd50, 10'd100};

always_comb begin
	current_corner_x = 10'd0;
	current_corner_y = 10'd0;
	real_pixel_x = 10'd0;
	real_pixel_y = 10'd0;
	if (show_player1 == 1'b0) begin
		//don't display
		is_player1 = 1'b0;
		addr_candidate = 15'd0;
	end
	else begin
		current_corner_x = image_upper_left_x[player1_current_image];
		current_corner_y = image_upper_left_y[player1_current_image];
		if (DrawX >= player1_pos_x && DrawY >= player1_pos_y) begin
			if ((DrawX - player1_pos_x <= single_image_size_x) && 
				 (DrawY - player1_pos_y <= single_image_size_y)) begin
				is_player1 = 1'b1;
				//default face dir is to left side (first and third column of image)
				real_pixel_x = DrawX - player1_pos_x + current_corner_x;
				real_pixel_y = DrawY - player1_pos_y + current_corner_y;
				addr_candidate = {5'd0,real_pixel_x} + {5'd0,source_image_size_x}*({5'd0, real_pixel_y});
				if (player1_face_dir)
					//right 1, left 0
					addr_candidate = addr_candidate + {5'd0,face_dir_offset_x};
			end
			else begin
				is_player1 = 1'b0;
				addr_candidate = 15'd0;
			end
		end
		else begin
			is_player1 = 1'b0;
			addr_candidate = 15'd0;
		end
	end
end

assign read_address = (is_player1) ? addr_candidate : 15'd0;
assign player1_data = (is_player1) ? readdata : 4'd0;
player1_RAM player1_RAM_inst(.*, .player1_data(readdata));

endmodule

//nearly the same code 
module player2(
	input logic Clk,
	input logic show_player2,
	input logic [9:0] player2_pos_x,
	input logic [9:0] player2_pos_y,
	input logic [3:0] player2_current_image,
	input logic player2_face_dir,
	input logic [9:0] DrawX, DrawY,
	output logic [3:0] player2_data,
	output is_player2
);

//assign player2_data = 4'd0;
//assign is_player2 = 1'b0;
logic [9:0] image_upper_left_x [0:5];
logic [9:0] image_upper_left_y [0:5];
logic [14:0] addr_candidate, read_address;
logic [3:0] readdata;
logic [9:0] current_corner_x, current_corner_y, real_pixel_x, real_pixel_y;
//offset to body center (+20, +25)
logic [9:0] source_image_size_x;
logic [9:0] source_image_size_y;
logic [9:0] single_image_size_x;
logic [9:0] single_image_size_y;
logic [9:0] face_dir_offset_x;

assign source_image_size_x = 10'd120;
assign source_image_size_y = 10'd150;
assign single_image_size_x = 10'd30;
assign single_image_size_y = 10'd50;
assign face_dir_offset_x = 10'd30;
assign image_upper_left_x = '{10'd0, 10'd0, 10'd0, 10'd60, 10'd60, 10'd60};
assign image_upper_left_y = '{10'd0, 10'd50, 10'd100, 10'd0, 10'd50, 10'd100};

always_comb begin
	current_corner_x = 10'd0;
	current_corner_y = 10'd0;
	real_pixel_x = 10'd0;
	real_pixel_y = 10'd0;
	if (show_player2 == 1'b0) begin
		//don't display
		is_player2 = 1'b0;
		addr_candidate = 15'd0;
	end
	else begin
		current_corner_x = image_upper_left_x[player2_current_image];
		current_corner_y = image_upper_left_y[player2_current_image];
		if (DrawX >= player2_pos_x && DrawY >= player2_pos_y) begin
			if ((DrawX - player2_pos_x <= single_image_size_x) && 
				 (DrawY - player2_pos_y <= single_image_size_y)) begin
				is_player2 = 1'b1;
				//default face dir is to left side (first and third column of image)
				real_pixel_x = DrawX - player2_pos_x + current_corner_x;
				real_pixel_y = DrawY - player2_pos_y + current_corner_y;
				addr_candidate = {5'd0,real_pixel_x} + {5'd0,source_image_size_x}*({5'd0, real_pixel_y});
				if (player2_face_dir)
					//right 1, left 0
					addr_candidate = addr_candidate + {5'd0,face_dir_offset_x};
			end
			else begin
				is_player2 = 1'b0;
				addr_candidate = 15'd0;
			end
		end
		else begin
			is_player2 = 1'b0;
			addr_candidate = 15'd0;
		end
	end
end

assign read_address = (is_player2) ? addr_candidate : 15'd0;
assign player2_data = (is_player2) ? readdata : 4'd0;
player2_RAM player2_RAM_inst(.*, .player2_data(readdata));

endmodule

module  player1_RAM
(
		input [14:0] read_address,
		input Clk,

		output logic [3:0] player1_data
);

//18000 = 120*150
logic [3:0] mem [0:17999];
initial
begin
	 $readmemh("sprites/player1.txt", mem);
end

always_ff @ (posedge Clk) begin
	player1_data <= mem[read_address];
end

endmodule

module  player2_RAM
(
		input [14:0] read_address,
		input Clk,

		output logic [3:0] player2_data
);

//18000 = 120*150
logic [3:0] mem [0:17999];
initial
begin
	 $readmemh("sprites/player2.txt", mem);
end

always_ff @ (posedge Clk) begin
	player2_data <= mem[read_address];
end

endmodule

