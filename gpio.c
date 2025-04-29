#include "gpio.h" 

void gpio_init(void) {
    RCC->APB2PCENR |= RCC_IOPAEN;   // enable port A clock

    GPIOA->CFGHR = 0x20000000;  // PA15: 2 MHz, push-pull output
}

void set_led_state(unsigned char state) {
    if (state) {
        GPIOA->OUTDR |= (1 << 15);
    } else {
        GPIOA->OUTDR &= ~(1 << 15);
    }
}
