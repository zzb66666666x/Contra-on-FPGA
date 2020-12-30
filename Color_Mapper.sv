//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper (
							  input logic [3:0] player1_data,
							  input logic [3:0] player2_data,
							  input logic [3:0] bullet1_data, bullet2_data, 
													  bullet3_data, bullet4_data, bullet5_data, bullet6_data, 
	                                      bullet7_data, bullet8_data, bullet9_data, bullet10_data,
							  input logic [3:0] HP_data,
							  input logic	[3:0] background_data,
							  input logic is_background,
							  input logic is_player1,
							  input logic is_player2,
							  input logic is_bullet1, is_bullet2, 
											  is_bullet3, is_bullet4, is_bullet5, is_bullet6,
											  is_bullet7, is_bullet8,is_bullet9, is_bullet10,
							  input logic is_HP,
							  
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
	 logic [23:0]background_palette [0:15];
	 logic [23:0]player1_palette [0:15];
	 logic [23:0]player2_palette [0:15];
	 logic [23:0]HP_palette [0:15];
	 logic [23:0]color, background_color, player1_color, player2_color, bullet_color, HP_color;
	 logic is_bullet;
	 
	 //assign palette
	assign background_palette = '{24'h005000,24'h000000, 24'hf83800, 24'hf0d0b0, 
				  24'h50ff00, 24'h0058f8, 24'hb7c70f, 24'hc80000, 
				  24'hbcbcbc, 24'h0a8700, 24'hd8ef00, 24'hfc7460, 
				  24'hfcbcb0, 24'h900000, 24'haeacae, 24'h363301};

	//mask color at the index 0: 0xc832c8 
	assign player1_palette = '{24'hc832c8, 24'h800080,24'h000000, 24'hf83800,
				  24'hf0d0b0,24'h00ffa8, 24'h0058f8, 24'hfcfcfc, 
				  24'hbcbcbc, 24'h0a8700, 24'hd8ff00, 24'hfc7460, 
				  24'hfcbcb0, 24'hf0bc3c, 24'haeacae, 24'h363301};

	assign player2_palette = '{24'hc832c8, 24'h800080,24'h000000, 24'hf83800,
				  24'hf0d0b0,24'h00ffa8, 24'h0058f8, 24'hfcfcfc, 
				  24'hbcbcbc, 24'h0a8700, 24'hd8ff00, 24'hfc7460, 
				  24'hfcbcb0, 24'hf0bc3c, 24'haeacae, 24'h363301};
			 
	assign HP_palette = '{24'hc832c8, 24'h800080,24'h000000, 24'hf83800,
				  24'hf0d0b0,24'h00ffa8, 24'h0058f8, 24'hfcfcfc, 
				  24'hbcbcbc, 24'h0a8700, 24'hd8ff00, 24'hfc7460, 
				  24'hfcbcb0, 24'hf0bc3c, 24'haeacae, 24'h363301};
											
	 //assign various colors
	 assign background_color = background_palette[background_data];
	 assign player1_color = player1_palette[player1_data];
	 assign player2_color = player2_palette[player2_data];
	 assign HP_color = HP_palette[HP_data];
	 
	 bullet_color_selector bullet_color_selector_inst(.*);
	 
	 //select color among colors
	 always_comb begin
			if (is_HP && HP_color != 24'hC832C8) begin
				color = HP_color;
			end
			else if (is_bullet && bullet_color != 24'hC832C8) begin
				color = bullet_color;
			end
			else if(is_player1 && player1_color != 24'hC832C8) begin
				color = player1_color;
			end
			else if(is_player2 && player2_color != 24'hC832C8) begin
				color = player2_color;
			end
			else begin
				color = background_color;
			end
	 end
	 
	 assign VGA_R = color[23:16];
	 assign VGA_G = color[15:8];
	 assign VGA_B = color[7:0];	 
	 
endmodule

module bullet_color_selector(
	input logic [3:0] bullet1_data, bullet2_data, 
					      bullet3_data, bullet4_data, bullet5_data, bullet6_data, 
					      bullet7_data, bullet8_data, bullet9_data, bullet10_data,
	input logic is_bullet1, is_bullet2, 
				   is_bullet3, is_bullet4, is_bullet5, is_bullet6,
				   is_bullet7, is_bullet8,is_bullet9, is_bullet10,
	output logic [23:0] bullet_color,
	output logic is_bullet
);

	logic [23:0] bullet_color1;
	logic [23:0] bullet_color2;
	logic [23:0] bullet_color3;
	logic [23:0] bullet_color4;
	logic [23:0] bullet_color5;
	logic [23:0] bullet_color6;
	logic [23:0] bullet_color7;
	logic [23:0] bullet_color8;
	logic [23:0] bullet_color9;
	logic [23:0] bullet_color10;

	logic [23:0]bullet_palette [0:15];
	assign bullet_palette = '{24'hc832c8, 24'h800080,24'h000000, 24'hf83800,
				  24'hf0d0b0,24'h00ffa8, 24'h0058f8, 24'hfcfcfc, 
				  24'hbcbcbc, 24'h0a8700, 24'hd8ff00, 24'hfc7460, 
				  24'hfcbcb0, 24'hf0bc3c, 24'haeacae, 24'h900000}; 
			  
	always_comb begin
		bullet_color1 = bullet_palette[bullet1_data];
		bullet_color2 = bullet_palette[bullet2_data];
		bullet_color3 = bullet_palette[bullet3_data];
		bullet_color4 = bullet_palette[bullet4_data];
		bullet_color5 = bullet_palette[bullet5_data];
		bullet_color6 = bullet_palette[bullet6_data];
		bullet_color7 = bullet_palette[bullet7_data];
		bullet_color8 = bullet_palette[bullet8_data];
		bullet_color9 = bullet_palette[bullet9_data];
		bullet_color10 = bullet_palette[bullet10_data];
		if (is_bullet1 && bullet_color1 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color1;		
		end
		else if (is_bullet2 && bullet_color2 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color2;
		end
		else if (is_bullet3 && bullet_color3 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color3;
		end
		else if (is_bullet4 && bullet_color4 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color4;
		end
		else if (is_bullet5 && bullet_color5 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color5;
		end
		else if (is_bullet6 && bullet_color6 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color6;
		end
		else if (is_bullet7 && bullet_color7 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color7;
		end
		else if (is_bullet8 && bullet_color8 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color8;
		end
		else if (is_bullet9 && bullet_color9 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color9;
		end
		else if (is_bullet10 && bullet_color10 != 24'hC832C8) begin
			is_bullet = 1'b1;
			bullet_color = bullet_color10;
		end
		else begin
			is_bullet = 1'b0;
			bullet_color = 24'hC832C8;
		end
	end
								  
								  
endmodule 
