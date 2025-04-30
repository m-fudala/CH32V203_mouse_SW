#include "gpio.h" 

void gpio_init(void) {
    RCC->APB2PCENR |= RCC_IOPAEN;   // enable port A clock

    GPIOA->CFGHR = GPIO_CFGHR_MODE15_1;  // PA15: 2 MHz, push-pull output
}

void set_led_state(unsigned char state) {
    if (state) {
        GPIOA->OUTDR |= GPIO_OUTDR_ODR15;
    } else {
        GPIOA->OUTDR &= ~GPIO_OUTDR_ODR15;
    }
}
