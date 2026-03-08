#!/bin/bash

export DISPLAY=:0

Xvfb :0 -screen 0 1280x800x24 &

sleep 2

startxfce4 &

x11vnc -display :0 -nopw -forever -shared -rfbport 5900 &

websockify --web=/usr/share/novnc/ 6080 localhost:5900