//created by Zhu Zhongbo 2020/12/12
#ifndef MAIN_USB_INTERFACE_H_
#define MAIN_USB_INTERFACE_H_

//main interface used by the game
#define MAX_KEY_SLOTS 6
#define MAX_KEY_USED 4
#include "alt_types.h"

typedef struct{
	alt_u32 key_pressed;
	alt_u8 keys[MAX_KEY_SLOTS];
}keycodes_t;

extern keycodes_t keycodes_info;

int usb_init();
void update_keycodes();

#endif
