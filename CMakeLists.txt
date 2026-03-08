cmake_minimum_required(VERSION 3.16)
project(MyApp C)

# Build SDL from the submodule

set(SDL_TEST OFF)
set(SDL_TEST_LIBRARY OFF)
set(SDL_EXAMPLES OFF)

add_subdirectory(external/SDL)

add_executable(app src/main.c)

target_link_libraries(app PRIVATE SDL3::SDL3)