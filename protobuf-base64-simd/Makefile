# Protobuf Base64 NEON 优化 - 构建配置

CC = gcc
CXX = g++
CFLAGS = -O3 -Wall -Wextra -march=armv8-a+simd
CXXFLAGS = $(CFLAGS) -std=c++17
LDFLAGS = -lgtest -lgtest_main -pthread

SRC_DIR = src
TEST_DIR = tests
BUILD_DIR = build

# 源文件
SRCS = $(SRC_DIR)/base64_neon.c
TEST_SRCS = $(TEST_DIR)/base64_test.cpp

# 目标
OBJS = $(BUILD_DIR)/base64_neon.o
TEST_BIN = $(BUILD_DIR)/base64_test

.PHONY: all clean test bench

all: $(TEST_BIN)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(TEST_BIN): $(OBJS) $(TEST_SRCS) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OBJS) $(TEST_SRCS) $(LDFLAGS) -o $@

test: $(TEST_BIN)
	./$(TEST_BIN)

bench: $(TEST_BIN)
	./$(TEST_BIN) --gtest_filter=*Benchmark*

clean:
	rm -rf $(BUILD_DIR)

# 依赖
$(BUILD_DIR)/base64_neon.o: $(SRC_DIR)/base64_neon.c $(SRC_DIR)/base64_neon.h
