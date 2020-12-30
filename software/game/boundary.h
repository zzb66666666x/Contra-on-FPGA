#ifndef BOUNDARY_H_
#define BOUNDARY_H_

#include "alt_types.h"
#include "objects.h"
#define PLATFORM_NUM 10
#define LEFT_MOST 0
#define SCREEN_TOP 0
#define SCREEN_BOTTOM 480
#define RIGHT_MOST 640

typedef struct{
	alt_32 lx;//left
	alt_32 rx;//right
	alt_32 y;//uniform y
	alt_32 id;
}platform_t;

typedef struct{
	alt_32 left_up_x;
	alt_32 left_up_y;
	alt_32 right_down_x;
	alt_32 right_down_y;
}bounding_box_t;

extern platform_t platforms[PLATFORM_NUM];

void boundary_init();
void boundary_check_player(player_t * player_ptr);
void boundary_check_bullet(bullet_t * bullet_ptr);
void check_hurt(player_t * player_ptr, bullet_t * bullet_ptr, alt_32 id);
alt_32 isclose(alt_32 a, alt_32 b);
alt_32 inbox(alt_32 x, alt_32 y, bounding_box_t * box);
#endif
