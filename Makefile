# Makefile

CC = gcc
CFLAGS = -Wall -Wextra -O2

.PHONY: all clean test

all: afl_integration

afl_integration: afl_integration.c
    $(CC) $(CFLAGS) -o afl_integration afl_integration.c

clean:
    rm -f afl_integration

test: afl_integration
    ./afl_integration
