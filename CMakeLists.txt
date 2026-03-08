cmake_minimum_required(VERSION 3.16)
project(MySDLApp C)

# Disable XTEST for headless / Codespaces
set(SDL_X11_XTEST OFF CACHE BOOL "Disable XTEST dependency" FORCE)
set(SDL_X11_OFFSCREEN=ON CACHE BOOL "Headless build" FORCE)

# Add SDL submodule
add_subdirectory(external/SDL)

# Build app
add_executable(app src/main.c)
target_link_libraries(app PRIVATE SDL3::SDL3)