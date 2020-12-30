module gamefile_reader(
	input logic [2047:0] gamefile,
	output logic [3:0] current_bg,
	output logic [9:0] player1_pos_x,
	output logic [9:0] player1_pos_y,
	output logic [3:0] player1_current_image,
	output logic player1_face_dir,
	output logic show_player1,
	output logic show_player2,
	output logic [9:0] player2_pos_x,
	output logic [9:0] player2_pos_y,
	output logic [3:0] player2_current_image,
	output logic player2_face_dir,
	output logic [9:0] bullet_status,
	output logic [9:0] bullet1_x,
	output logic [9:0] bullet1_y,
	output logic [9:0] bullet2_x,
	output logic [9:0] bullet2_y,
	output logic [9:0] bullet3_x,
	output logic [9:0] bullet3_y,
	output logic [9:0] bullet4_x,
	output logic [9:0] bullet4_y,
	output logic [9:0] bullet5_x,
	output logic [9:0] bullet5_y,
	output logic [9:0] bullet6_x,
	output logic [9:0] bullet6_y,
	output logic [9:0] bullet7_x,
	output logic [9:0] bullet7_y,
	output logic [9:0] bullet8_x,
	output logic [9:0] bullet8_y,
	output logic [9:0] bullet9_x,
	output logic [9:0] bullet9_y,
	output logic [9:0] bullet10_x,
	output logic [9:0] bullet10_y,
	output logic [4:0] player1_HP,
	output logic [4:0] player2_HP,
   output logic [9:0] player1_HP_start_x,
   output logic [9:0] player1_HP_start_y,
   output logic [9:0] player2_HP_start_x,
   output logic [9:0] player2_HP_start_y,
	output logic [9:0] HP_bar_interval
);

	assign	current_bg = gamefile[3:0];
	assign	player1_pos_x = gamefile[41:32];
	assign	player1_pos_y = gamefile[73:64];
	assign	player1_current_image = gamefile[99:96];
	assign	player1_face_dir = gamefile[128];
	assign	show_player1 = gamefile[160];
	assign   show_player2 = gamefile[161];
	assign	player2_pos_x = gamefile[201:192];
	assign	player2_pos_y = gamefile[233:224];
	assign	player2_current_image = gamefile[259:256];	
	assign	player2_face_dir = gamefile[288];	
	assign	bullet_status = gamefile[329:320];	
	assign	bullet1_x = gamefile[361:352];	
	assign	bullet1_y = gamefile[393:384];
	assign	bullet2_x = gamefile[425:416];
	assign	bullet2_y = gamefile[457:448];
	assign	bullet3_x = gamefile[489:480];	
	assign	bullet3_y = gamefile[521:512];
	assign	bullet4_x = gamefile[553:544];
	assign	bullet4_y = gamefile[585:576];	
	assign	bullet5_x = gamefile[617:608];
	assign	bullet5_y = gamefile[649:640];
	assign	bullet6_x = gamefile[681:672];
	assign	bullet6_y = gamefile[713:704];
	assign	bullet7_x = gamefile[745:736];
	assign	bullet7_y = gamefile[777:768];
	assign	bullet8_x = gamefile[809:800];
	assign	bullet8_y = gamefile[841:832];
	assign	bullet9_x = gamefile[873:864];
	assign	bullet9_y = gamefile[905:896];
	assign	bullet10_x = gamefile[937:928];
	assign	bullet10_y = gamefile[969:960];
	assign	player1_HP = gamefile[996:992];
	assign	player2_HP = gamefile[1028:1024];
   assign player1_HP_start_x = gamefile[1065:1056];
   assign player1_HP_start_y = gamefile[1097:1088];
   assign player2_HP_start_x = gamefile[1129:1120];
   assign player2_HP_start_y = gamefile[1161:1152]; 
   assign HP_bar_interval = gamefile[1193:1184];
endmodule
