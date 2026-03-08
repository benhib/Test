cmake_minimum_required(VERSION 3.16)
project(MySDLApp C)

# Build SDL3 from submodule
add_subdirectory(external/SDL)

add_executable(app src/main.c)
target_link_libraries(app PRIVATE SDL3::SDL3)