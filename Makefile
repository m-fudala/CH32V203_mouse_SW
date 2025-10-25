CC = riscv-wch-elf-
CFLAGS = -c -march=rv32imac -mabi=ilp32 -ggdb -O0

BUILD_DIR = build

LINKER = Link.ld
LFLAGS = -nostartfiles

STARTUP_NAME = startup_ch32v20x_D6.S

OBJCOPYFLAGS = -O ihex

flash: main.hex
	wlink erase && wlink flash main.hex -v

clean:
	rm -f $(BUILD_DIR)/*

$(BUILD_DIR)/main.o: main.c
	mkdir -p $(BUILD_DIR)
	$(CC)gcc main.c -o $(BUILD_DIR)/main.o $(CFLAGS)

$(BUILD_DIR)/startup.o: $(STARTUP_NAME)
	$(CC)gcc $(STARTUP_NAME) -o $(BUILD_DIR)/startup.o $(CFLAGS)

$(BUILD_DIR)/gpio.o: gpio.c
	$(CC)gcc gpio.c -o $(BUILD_DIR)/gpio.o $(CFLAGS)

$(BUILD_DIR)/exti.o: exti.c
	$(CC)gcc exti.c -o $(BUILD_DIR)/exti.o $(CFLAGS)

$(BUILD_DIR)/timers.o: timers.c
	$(CC)gcc timers.c -o $(BUILD_DIR)/timers.o $(CFLAGS)

$(BUILD_DIR)/main.elf: $(BUILD_DIR)/main.o $(BUILD_DIR)/startup.o $(BUILD_DIR)/gpio.o $(BUILD_DIR)/exti.o $(BUILD_DIR)/timers.o
	$(CC)gcc $(BUILD_DIR)/*.o -T $(LINKER) -o $(BUILD_DIR)/main.elf $(LFLAGS)

main.hex: $(BUILD_DIR)/main.elf
	$(CC)objcopy $(OBJCOPYFLAGS) $(BUILD_DIR)/main.elf main.hex