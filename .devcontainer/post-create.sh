#!/bin/bash

# Post-Create Script für GitHub Codespaces
# Wird automatisch beim Container-Start ausgeführt

export DISPLAY=:1

echo "╔════════════════════════════════════════════╗"
echo "║   SDL3 Codespaces Setup wird gestartet    ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# ===== SCHRITT 1: Xvfb starten =====
echo "[1/5] Starting Virtual Display (Xvfb)..."
if command -v Xvfb &> /dev/null; then
    nohup Xvfb :1 -screen 0 1024x768x24 > /tmp/xvfb.log 2>&1 &
    sleep 2
    echo "✓ Xvfb started"
else
    echo "✗ Xvfb not found - will retry"
fi

# ===== SCHRITT 2: x11vnc starten =====
echo "[2/5] Starting VNC Server..."
if command -v x11vnc &> /dev/null; then
    nohup x11vnc -display :1 -nopw -forever -shared > /tmp/vnc.log 2>&1 &
    sleep 1
    echo "✓ VNC Server started"
else
    echo "✗ x11vnc not found - skipping"
fi

# ===== SCHRITT 3: noVNC starten =====
echo "[3/5] Starting noVNC..."
if command -v websockify &> /dev/null; then
    nohup websockify --web=/usr/share/novnc/ 6080 localhost:5900 > /tmp/novnc.log 2>&1 &
    sleep 1
    echo "✓ noVNC started on port 6080"
else
    echo "✗ websockify not found - skipping"
fi

# ===== SCHRITT 4: XFCE Desktop starten =====
echo "[4/5] Starting XFCE Desktop..."
if command -v startxfce4 &> /dev/null; then
    nohup startxfce4 > /tmp/xfce4.log 2>&1 &
    sleep 3
    echo "✓ XFCE Desktop started"
else
    echo "✗ startxfce4 not found - skipping"
fi

# ===== SCHRITT 5: Projekt bauen =====
echo "[5/5] Building SDL3 Application..."

if [ ! -d "/workspaces/Test" ]; then
    echo "✗ /workspaces/Test not found"
    exit 0
fi

cd /workspaces/Test

# Git Submodule initialisieren
echo "  → Initializing SDL3 submodule..."
if git submodule update --init --recursive 2>/dev/null; then
    echo "  ✓ Submodule initialized"
else
    echo "  ⚠ Submodule init had issues (may be OK)"
fi

# Build-Verzeichnis erstellen
mkdir -p build
cd build

# CMake ausführen
echo "  → Running CMake..."
if cmake .. > /tmp/cmake.log 2>&1; then
    echo "  ✓ CMake OK"
else
    echo "  ✗ CMake failed"
    cat /tmp/cmake.log
    exit 0
fi

# Make ausführen
echo "  → Building with make..."
if make > /tmp/make.log 2>&1; then
    echo "  ✓ Build successful"
else
    echo "  ✗ Make failed"
    cat /tmp/make.log
    exit 0
fi

# Auf Desktop kopieren
if [ -f "./app" ]; then
    mkdir -p /root/Desktop
    cp ./app /root/Desktop/main
    chmod +x /root/Desktop/main
    echo "  ✓ App installed to /root/Desktop/main"
else
    echo "  ✗ Executable not found"
fi

echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   ✓ Setup abgeschlossen!                 ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "🌐 Access:"
echo "   noVNC: http://localhost:6080/vnc.html"
echo ""
echo "🖥️  Desktop:"
echo "   /root/Desktop/main (die App)"
echo ""

exit 0