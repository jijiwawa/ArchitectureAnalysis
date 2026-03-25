CC = g++
CFLAGS = -std=c++17 -O3 -I./include

# 检测 NEON 支持
ifeq ($(shell uname -m),aarch64)
    CFLAGS += -D__ARM_NEON
endif

SRCS = src/half_distance_native.c src/half_distance_neon.c \
       src/bit_distance_native.c src/bit_distance_neon.c \
       src/vector_distance_native.c src/vector_distance_neon.c

OBJS = $(SRCS:.c=.o)

all: test

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

libpgvector_neon.a: $(OBJS)
	ar rcs $@ $^

test: libpgvector_neon.a tests/simple_test.cpp
	$(CC) $(CFLAGS) tests/simple_test.cpp -L. -lpgvector_neon -o test
	./test

clean:
	rm -f $(OBJS) test libpgvector_neon.a

.PHONY: all test clean
