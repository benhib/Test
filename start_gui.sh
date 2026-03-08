#!/bin/bash
set -e

# Start Xvfb on :1
Xvfb :1 -screen 0 1024x768x24 &

# Set display for SDL
export DISPLAY=:1

# Start Openbox window manager
openbox &

# Start x11vnc on :1
x11vnc -display :1 -nopw -forever &

# Launch noVNC web client on port 8080
/opt/novnc/utils/launch.sh --vnc localhost:5900 &

# Run the SDL app
./build/app