CC = gcc
CXX = g++

all: build/packed_test build/packed_bench

.PHONY: all clean test bench clean

build/packed_neon.o: src/packed_neon.c
	$(CC) $(CFLAGS) -c $< -o $@

build/packed_test: build/packed_neon.o tests/packed_test.cpp
	$(CXX) $(CXXFLAGS) -lgtest -lgtest_main -pthread -o $@

build/packed_bench: build/packed_neon.o tests/packed_bench.cpp
	$(CXX) $(CXXFLAGS) -o $@

test: build/packed_test
	 ./build/packed_test

bench: build/packed_bench
  ./build/packed_bench

clean:
	rm -rf build

.PHONY: all test bench
