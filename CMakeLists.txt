cmake_minimum_required(VERSION 3.14)
project(bitset_project CXX)
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
)

add_executable(bitset bitset.cpp)
