#!/bin/bash

export DISPLAY=:1

vncserver :1 -geometry 1280x800 -depth 24

websockify --web=/usr/share/novnc/ 6080 localhost:5901