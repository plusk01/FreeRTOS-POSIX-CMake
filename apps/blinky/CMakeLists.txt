cmake_minimum_required(VERSION 3.15)
project(blinky)

include(${CMAKE_SOURCE_DIR}/../../cmake/freertos.posix.cmake)

add_executable(blinky src/main.c src/main_blinky.c src/console.c)
target_include_directories(blinky PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>)
target_include_directories(blinky PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)
target_compile_definitions(blinky PRIVATE projCOVERAGE_TEST=1)
freertos_target_add_kernel(blinky)