#!/bin/bash
set -e

# Start virtual X server
Xvfb :1 -screen 0 1024x768x24 &

export DISPLAY=:1

# Start lightweight desktop
openbox &

# Start VNC server
x11vnc -display :1 -nopw -forever &

# Launch noVNC for browser access
/opt/novnc/utils/launch.sh --vnc localhost:5900 &

# Launch SDL app
./build/app

# Keep terminal open
bash