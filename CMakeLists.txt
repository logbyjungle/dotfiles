cmake_minimum_required(VERSION 3.14)
project(project CXX)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_compile_options(
  -Wall
  -Wextra
  -Werror
  -Wpedantic
  -Wshadow
  -Wconversion
  -Wsign-conversion
  -Wnull-dereference
  -Wformat=2
  -Wnon-virtual-dtor
  -Wunused
  -Wlogical-op
  -Wduplicated-branches
  -Wduplicated-cond
  -Wcast-align
  -Wfloat-equal
  -Wswitch-enum
  -Wreturn-type
  -Wmissing-noreturn
  -Wunreachable-code
  -O3
  -flto
  -funroll-loops
  -fsanitize=address # remove on final build
  -fno-inline # remove on final build
  -fno-omit-frame-pointer # remove on final build
  -pg # remove on final build
)

add_executable(main main.cpp)
