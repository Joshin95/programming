PHONY: crossing		

test_queue:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL queue.c test_queue.c -o test_queue

	avr-objcopy -Oihex test_queue test_queue.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U test_queue.hex

test_lamp:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL gpio_device.c lamp.c test_lamp.c -o test_lamp

	avr-objcopy -Oihex test_lamp test_lamp.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U test_lamp.hex

test_semaph:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL gpio_device.c lamp.c semaph.c test_semaph.c -o test_semaph

	avr-objcopy -Oihex test_semaph test_semaph.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U test_semaph.hex

test_control:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL gpio_device.c lamp.c semaph.c control.c test_control.c -o test_control

	avr-objcopy -Oihex test_control test_control.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U test_control.hex


test_blck_serial:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL queue.c serial_device.c blck_serial.c -o test_blck_serial

	avr-objcopy -Oihex test_control test_blck_serial.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U test_blck_serial.hex


test_serial_device:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL queue.c serial_device.c test_serial_device.c -o test_serial_device

	avr-objcopy -Oihex test_serial_device test_serial_device.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U test_serial_device.hex

main:

crossing:
	avr-gcc -std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL gpio_device.c crossing.c semaph.c serial_device.c control.c lamp.c queue.c blck_serial.c -o crossing

	avr-objcopy -Oihex crossing crossing.hex	

	sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U crossing.hex
