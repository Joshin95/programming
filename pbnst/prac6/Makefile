CC=avr-gcc
CFLAGS=-std=c99 -Os -mmcu=atmega328p -fshort-enums -DF_CPU=16000000UL
LDFLAGS=-Os -mmcu=atmega328p

.PHONY: clean

%.ihex: %
	avr-objcopy -Oihex $< $@

%.implanta: %.ihex
	avrdude -c arduino -p atmega328p -P /dev/ttyACM0 -U $<



clean:
	rm -f *~ \#*\# *.ihex *.hex *.o *.a


blck_serial.o: blck_serial.c serial_device.h blck_serial.h
control.o: control.c lamp.h gpio_device.h semaph.h control.h timer.h
crossing.o: crossing.c serial_device.h queue.h blck_serial.h \
	 gpio_device.h lamp.h semaph.h control.h ether.h
ether.o: ether.c mtbl.h mchar.h modulator.h timer.h queue.h ether.h \
	serial_device.h
gpio_device.o: gpio_device.c gpio_device.h
lamp.o: lamp.c gpio_device.h lamp.h
mchar.o: mchar.c mchar.h
modulator.o: modulator.c modulator.h gpio_device.h
mtbl.o: mtbl.c mtbl.h mchar.h
queue.o: queue.c queue.h
semaph.o: semaph.c lamp.h gpio_device.h semaph.h
serial_device.o: serial_device.c serial_device.h queue.h
test_modulator.o: test_modulator.c modulator.h gpio_device.h
test_mtbl.o: test_mtbl.c mtbl.h mchar.h
test_timer2.o: test_timer2.c timer.h gpio_device.h
test_timer3.o: test_timer3.c timer.h gpio_device.h
test_timer.o: test_timer.c timer.h gpio_device.h
timer.o: timer.c timer.h serial_device.h gpio_device.h


test_timer3: test_timer3.o timer.o
test_timer2: test_timer2.o timer.o
test_timer: test_timer.o timer.o gpio_device.o
test_modulator: test_modulator.o modulator.o
test_mtbl: mchar.o mtbl.o test_mtbl.o
crossing: crossing.o gpio_device.o blck_serial.o timer.o \
	crossing.o ether.o modulator.o mchar.o mtbl.o queue.o \
	lamp.o semaph.o control.o serial_device.o
