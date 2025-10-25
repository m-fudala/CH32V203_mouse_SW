/*

*/

#ifndef TIMERS_H_
#define TIMERS_H_

#include "ch32v20x.h"

void pwm_init(void);
void pwm_set_state(unsigned char state);
void pwm_set_duty_cycle(unsigned char duty_cycle);

#endif
