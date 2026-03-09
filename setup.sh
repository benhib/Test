#!/bin/bash

set -e

echo "╔════════════════════════════════════════════╗"
echo "║   SDL3 Codespaces Setup                    ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# ===== SCHRITT 1: Abhängigkeiten installieren =====
echo "[1/4] Installing dependencies..."
echo "(Dies kann 3-5 Minuten dauern...)"
echo ""

apt-get update -qq
apt-get install -y -qq \
  xvfb x11vnc novnc websockify \
  xfce4 xfce4-terminal \
  cmake build-essential git \
  libx11-dev libxext-dev libxrandr-dev libxinerama-dev \
  libxcursor-dev libxi-dev libxfixes-dev libxss-dev \
  libxtst-dev libwayland-dev libxkbcommon-dev \
  libdbus-1-dev libudev-dev libgl1-mesa-dev libasound2-dev

echo "✓ Dependencies installed"
echo ""

# ===== SCHRITT 2: SDL3 Submodule initialisieren =====
echo "[2/4] Initializing SDL3 submodule..."

cd /workspaces/Test

# Prüfe ob .git existiert
if [ ! -d ".git" ]; then
    echo "✗ Not a git repository"
    exit 1
fi

git submodule update --init --recursive

if [ -f "external/SDL/CMakeLists.txt" ]; then
    echo "✓ SDL3 submodule initialized"
else
    echo "✗ SDL3 CMakeLists.txt still not found"
    exit 1
fi
echo ""

# ===== SCHRITT 3: Projekt bauen =====
echo "[3/4] Building SDL3 application..."

rm -rf build
mkdir -p build
cd build

echo "  → Running CMake..."
cmake .. > cmake.log 2>&1 || (cat cmake.log && exit 1)

echo "  → Building..."
make > make.log 2>&1 || (cat make.log && exit 1)

if [ ! -f "app" ]; then
    echo "✗ Build failed - executable not found"
    exit 1
fi

echo "✓ Build successful"
echo ""

# ===== SCHRITT 4: Desktop vorbereiten =====
echo "[4/4] Setting up desktop..."

mkdir -p /root/Desktop
cp app /root/Desktop/main
chmod +x /root/Desktop/main

echo "✓ App installed to /root/Desktop/main"
echo ""

# ===== Desktop Services starten =====
echo "Starting desktop services..."
echo ""

export DISPLAY=:1

# Xvfb
echo "  → Starting Xvfb..."
nohup Xvfb :1 -screen 0 1024x768x24 > /tmp/xvfb.log 2>&1 &
sleep 2

# x11vnc
echo "  → Starting x11vnc..."
nohup x11vnc -display :1 -nopw -forever -shared > /tmp/vnc.log 2>&1 &
sleep 1

# websockify
echo "  → Starting websockify..."
nohup websockify --web=/usr/share/novnc/ 6080 localhost:5900 > /tmp/novnc.log 2>&1 &
sleep 1

# XFCE
echo "  → Starting XFCE..."
nohup startxfce4 > /tmp/xfce4.log 2>&1 &
sleep 3

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   ✓ Setup Complete!                       ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "🌐 Access your desktop:"
echo "   http://localhost:6080/vnc.html"
echo ""
echo "🖥️  Your app is on the desktop:"
echo "   /root/Desktop/main"
echo ""
echo "Double-click 'main' to start the application!"
echo ""