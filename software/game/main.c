#include "system.h"
#include "alt_types.h"
#include <stdio.h>
#include "keyboard.h"
#include "game_logic.h"
#include "USBDriver/main_usb_interface.h"

game_state_t game_state = GAME_PREPARE;
alt_32 prev_frame_clk = 0;
alt_32 current_frame_clk = 0;

int main()
{
	usb_init();
	while(1){
		prev_frame_clk = current_frame_clk;
		current_frame_clk = frame_clk();
		update_keycodes();
		switch(game_state){
		case GAME_PREPARE:
			game_init(&game_state);
			break;
		case START_MENU:
			game_start(&game_state);
			break;
		case IN_GAME:
			if (~prev_frame_clk && current_frame_clk)
				game_loop(&game_state);//one new frame's calculation
			break;
		case GAME_OVER:
			if (~prev_frame_clk && current_frame_clk)
				game_over(&game_state);
			break;
		}
		update_gamefile(&game_state);
	}
	return 0;
}
