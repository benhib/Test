cmake_minimum_required(VERSION 3.16)
project(MySDLApp C)

# Disable XTEST and other optional X11 deps for headless mode
set(SDL_X11_XTEST OFF CACHE BOOL "Disable XTEST dependency" FORCE)
set(SDL_X11_OFFSCREEN=ON CACHE BOOL "Headless build" FORCE)

# Build SDL3 from submodule
add_subdirectory(external/SDL)

# Your app
add_executable(app src/main.c)
target_link_libraries(app PRIVATE SDL3::SDL3)

# Optional: run app with Xvfb automatically
add_custom_target(run
    COMMAND Xvfb :1 -screen 0 1024x768x24 &
    COMMAND DISPLAY=:1 ./app
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)