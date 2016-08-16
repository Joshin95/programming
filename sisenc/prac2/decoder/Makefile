CC=avr-gcc
CPPFLAGS=-DF_CPU=16000000UL
CFLAGS=-Wall -std=c99 -Os -mmcu=atmega328p -fshort-enums -Ilibpbn
LDFLAGS=-mmcu=atmega328p
IMPLANTA=sudo avrdude -c arduino -p atmega328p -P /dev/ttyACM0

vpath lib% libpbn


.PHONY: all
all: libpbn decoder

decoder: decoder.o -lpbn

decoder.o: decoder.c


.PHONY: libpbn
libpbn:
	$(MAKE) -C libpbn
