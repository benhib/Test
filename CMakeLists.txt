cmake_minimum_required(VERSION 3.16)
project(SDL3Test C)

find_package(SDL3 REQUIRED)

add_executable(app src/main.c)

target_link_libraries(app PRIVATE SDL3::SDL3)