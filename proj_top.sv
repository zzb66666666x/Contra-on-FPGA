//-------------------------------------------------------------------------
//      proj_top.sv                                                          --
//
//-------------------------------------------------------------------------


module proj_top( 
				input               CLOCK_50,
				input        [3:0]  KEY,          //bit 0 is set up as Reset	
				output logic [6:0]  HEX0,
				output logic [6:0]  HEX1,
				output logic [6:0]  HEX2,
				output logic [6:0]  HEX3,
				output logic [6:0]  HEX4,
				output logic [6:0]  HEX5,
				output logic [6:0]  HEX6,
				output logic [6:0]  HEX7,	
				output logic [3:0]  LEDG,
				// VGA Interface 
				output logic [7:0]  VGA_R,        //VGA Red
										  VGA_G,        //VGA Green
										  VGA_B,        //VGA Blue
				output logic        VGA_CLK,      //VGA Clock
										  VGA_SYNC_N,   //VGA Sync signal
										  VGA_BLANK_N,  //VGA Blank signal
										  VGA_VS,       //VGA virtical sync signal
										  VGA_HS,       //VGA horizontal sync signal
				// CY7C67200 Interface
				// these wires will be arranged to the chip in pin planner
				inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
				output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
				output logic        OTG_CS_N,     //CY7C67200 Chip Select
										  OTG_RD_N,     //CY7C67200 Write
										  OTG_WR_N,     //CY7C67200 Read
										  OTG_RST_N,    //CY7C67200 Reset
				input               OTG_INT,      //CY7C67200 Interrupt
				// SDRAM Interface for Nios II Software
				output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
				inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
				output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
				output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
				output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
										  DRAM_CAS_N,   //SDRAM Column Address Strobe
										  DRAM_CKE,     //SDRAM Clock Enable
										  DRAM_WE_N,    //SDRAM Write Enable
										  DRAM_CS_N,    //SDRAM Chip Select
										  DRAM_CLK,      //SDRAM Clock
			   input        [17:0] SW, 
				output logic [17:0] LEDR,
				inout  wire         I2C_SDAT,
				output logic        I2C_SCLK, AUD_XCK, AUD_BCLK, AUD_DACLRCK, AUD_DACDAT
);
    
    logic Reset_h, Clk;
    
	 //define clk, reset
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
	 //internal signals
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
	 logic [9:0] DrawX, DrawY;
    logic frame_clk;
	 logic [7:0] frame_buffer_out;
	 logic [2047:0] gamefile;
	 //gamefile variables
	 logic [3:0] current_bg;
	 logic [9:0] player1_pos_x;
	 logic [9:0] player1_pos_y;
	 logic [3:0] player1_current_image;
	 logic player1_face_dir;
	 logic show_player1;
	 logic show_player2;
	 logic [9:0] player2_pos_x;
	 logic [9:0] player2_pos_y;
	 logic [3:0] player2_current_image;
	 logic player2_face_dir;
	 logic [9:0] bullet_status;
	 logic [9:0] bullet1_x;
	 logic [9:0] bullet1_y;
	 logic [9:0] bullet2_x;
	 logic [9:0] bullet2_y;
	 logic [9:0] bullet3_x;
	 logic [9:0] bullet3_y;
	 logic [9:0] bullet4_x;
	 logic [9:0] bullet4_y;
	 logic [9:0] bullet5_x;
	 logic [9:0] bullet5_y;
	 logic [9:0] bullet6_x;
	 logic [9:0] bullet6_y;
	 logic [9:0] bullet7_x;
	 logic [9:0] bullet7_y;
	 logic [9:0] bullet8_x;
	 logic [9:0] bullet8_y;
	 logic [9:0] bullet9_x;
	 logic [9:0] bullet9_y;
	 logic [9:0] bullet10_x;
	 logic [9:0] bullet10_y;
	 logic [4:0] player1_HP;
	 logic [4:0] player2_HP;
	 logic [9:0] player1_HP_start_x;
	 logic [9:0] player1_HP_start_y;
	 logic [9:0] player2_HP_start_x;
	 logic [9:0] player2_HP_start_y;
	 logic [9:0] HP_bar_interval;
	 //frame clk
	 assign frame_clk = VGA_VS;
	 //RGB: use color mapper
	 logic is_background, is_player1, is_player2, is_HP;
	 logic [3:0] player1_data, player2_data, bullet_data, HP_data, background_data;
	 logic is_bullet1, is_bullet2, is_bullet3, is_bullet4, is_bullet5, is_bullet6,
			 is_bullet7, is_bullet8,is_bullet9, is_bullet10; 
	 logic [3:0] bullet1_data, bullet2_data, bullet3_data, bullet4_data, bullet5_data, bullet6_data, 
	       bullet7_data, bullet8_data, bullet9_data, bullet10_data;
	 
   // Interface between NIOS II and EZ-OTG chip
	hpi_io_intf hpi_io_inst(
		.Clk(Clk),
		.Reset(Reset_h),
		// signals connected to NIOS II
		.from_sw_address(hpi_addr),
		.from_sw_data_in(hpi_data_in),
		.from_sw_data_out(hpi_data_out),
		.from_sw_r(hpi_r),
		.from_sw_w(hpi_w),
		.from_sw_cs(hpi_cs),
		.from_sw_reset(hpi_reset),
		// signals connected to EZ-OTG chip
		.OTG_DATA(OTG_DATA),    
		.OTG_ADDR(OTG_ADDR),    
		.OTG_RD_N(OTG_RD_N),    
		.OTG_WR_N(OTG_WR_N),    
		.OTG_CS_N(OTG_CS_N),
		.OTG_RST_N(OTG_RST_N)
	);

	final_soc nios_system(
		.clk_clk(Clk),         
		.reset_reset_n(1'b1),    // Never reset NIOS
		.sdram_wire_addr(DRAM_ADDR), 
		.sdram_wire_ba(DRAM_BA),   
		.sdram_wire_cas_n(DRAM_CAS_N),
		.sdram_wire_cke(DRAM_CKE),  
		.sdram_wire_cs_n(DRAM_CS_N), 
		.sdram_wire_dq(DRAM_DQ),   
		.sdram_wire_dqm(DRAM_DQM),  
		.sdram_wire_ras_n(DRAM_RAS_N),
		.sdram_wire_we_n(DRAM_WE_N), 
		.sdram_clk_clk(DRAM_CLK),
		.otg_hpi_address_export(hpi_addr),
		.otg_hpi_data_in_port(hpi_data_in),
		.otg_hpi_data_out_port(hpi_data_out),
		.otg_hpi_cs_export(hpi_cs),
		.otg_hpi_r_export(hpi_r),
		.otg_hpi_w_export(hpi_w),
		.otg_hpi_reset_export(hpi_reset),        
		//gamefile
		.gamefile_export_data(gamefile),
		//sync the frame clk to C code
		.frame_sync_export(frame_clk)
    );
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    VGA_controller vga_controller_instance(
		.Clk,
		.Reset(Reset_h),
		.VGA_HS,
		.VGA_VS,
		.VGA_CLK,
		.VGA_BLANK_N,
		.VGA_SYNC_N,
		.DrawX,
		.DrawY
	 );

	//color mapper
	color_mapper color_mapper_inst(.*);
	
	//background
	background background_inst(
		.Clk(Clk),
		.current_bg(current_bg),
		.DrawX(DrawX),
		.DrawY(DrawY),
		.background_data(background_data),
		.is_background(is_background)
	);
	
	//gamefile reader
	gamefile_reader gamefile_reader_inst(.*);
	
	//bullets (at most 10)
	bullets bullets_inst(.*);
	
	//players (1 & 2)
	player1 player1_inst(.*);
	
	player2 player2_inst(.*);
	
	//HP_bar (at most 10)
	HP_bar HP_bar_inst(.*);
	
	Sound_Top Sound_Top_inst( 
        .clk(Clk), .reset(KEY[0]),
        .SDIN(I2C_SDAT), .SCLK(I2C_SCLK), .USB_clk(AUD_XCK), .BCLK(AUD_BCLK),
        .DAC_LR_CLK(AUD_DACLRCK), .DAC_DATA(AUD_DACDAT), .ACK_LEDR(LEDR[2:0])
   );
	 
	HexDriver hexdrv0 (
		.In(4'd0),
		.Out(HEX0)
	);
	HexDriver hexdrv1 (
		.In(4'd0),
		.Out(HEX1)
	);
	HexDriver hexdrv2 (
		.In(4'd0),
		.Out(HEX2)
	);
	HexDriver hexdrv3 (
		.In(4'd0),
		.Out(HEX3)
	);
	HexDriver hexdrv4 (
		.In(4'd0),
		.Out(HEX4)
	);
	HexDriver hexdrv5 (
		.In(4'd0),
		.Out(HEX5)
	);
	HexDriver hexdrv6 (
		.In(4'd0),
		.Out(HEX6)
	);
	HexDriver hexdrv7 (
		.In(4'd0),
		.Out(HEX7)
	);
    
endmodule
