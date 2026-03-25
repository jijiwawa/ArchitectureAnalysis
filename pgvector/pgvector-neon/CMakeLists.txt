cmake_minimum_required(VERSION 3.10)
project(pgvector_neon CXX C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# 编译选项
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -Wall")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -Wall")

# ARM NEON 支持 (aarch64 默认启用 NEON)
if(CMAKE_SYSTEM_PROCESSOR MATCHES "arm|aarch64")
    add_definitions(-D__ARM_NEON)
endif()

# 源文件
set(ALL_SOURCES
    src/half_distance_native.c
    src/half_distance_neon.c
    src/bit_distance_native.c
    src/bit_distance_neon.c
    src/vector_distance_native.c
    src/vector_distance_neon.c
)

# 库
add_library(pgvector_neon STATIC ${ALL_SOURCES})
target_include_directories(pgvector_neon PUBLIC ${CMAKE_SOURCE_DIR}/include)

# 测试
find_package(GTest)
if(GTest_FOUND)
    enable_testing()
    
    add_executable(test_all tests/test_all.cpp)
    target_link_libraries(test_all pgvector_neon GTest::gtest GTest::gtest_main pthread)
    
    add_test(NAME AllTests COMMAND test_all)
endif()

# 基准测试
add_executable(benchmark tests/benchmark.cpp)
target_link_libraries(benchmark pgvector_neon)

# 安装
install(TARGETS pgvector_neon DESTINATION lib)
install(DIRECTORY include/ DESTINATION include)
