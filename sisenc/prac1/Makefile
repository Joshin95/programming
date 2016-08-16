.PHONY : loadmain
loadmain: goertzel.hex
	avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U goertzel.hex
	rm -f *~ *.hex goertzel

goertzel: adc.c serial_device.c control_PWM_TMR1.c  control_TMR0.c control_PWM_TMR1.h control_TMR0.h adc.h serial_device.h goertzel3.c
	avr-gcc -std=c99 -Wall -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL goertzel3.c control_PWM_TMR1.c control_TMR0.c serial_device.c adc.c -o goertzel

goertzel.hex: goertzel
	avr-objcopy -Oihex goertzel goertzel.hex


