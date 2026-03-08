cmake_minimum_required(VERSION 3.16)
project(MySDLApp C)

# Minimal SDL build without X11/Wayland/audio to avoid extra dependencies
set(SDL_X11_XTEST OFF CACHE BOOL "Disable XTEST" FORCE)
set(SDL_VIDEO_X11 OFF CACHE BOOL "Disable X11 video" FORCE)
set(SDL_VIDEO_WAYLAND OFF CACHE BOOL "Disable Wayland video" FORCE)
set(SDL_AUDIO OFF CACHE BOOL "Disable audio" FORCE)

# Add SDL submodule
add_subdirectory(external/SDL)

# Build app
add_executable(app src/main.c)
target_link_libraries(app PRIVATE SDL3::SDL3)