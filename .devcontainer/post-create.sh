#!/bin/bash

set -e  # Exit on error

echo "╔════════════════════════════════════════════╗"
echo "║   SDL3 Codespaces - Setup wird gestartet  ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# ===== SCHRITT 1: Starte Virtual Display (Xvfb) =====
echo "[1/5] Starting Virtual Display (Xvfb)..."
export DISPLAY=:1

# Starte Xvfb im Hintergrund
nohup Xvfb :1 -screen 0 1024x768x24 > /tmp/xvfb.log 2>&1 &
XVFB_PID=$!
sleep 2  # Warte bis Xvfb startet

if ps -p $XVFB_PID > /dev/null; then
    echo "✓ Xvfb gestartet (PID: $XVFB_PID)"
else
    echo "✗ Xvfb konnte nicht gestartet werden"
    cat /tmp/xvfb.log
    exit 1
fi

# ===== SCHRITT 2: Starte VNC Server =====
echo "[2/5] Starting VNC Server..."
nohup x11vnc -display :1 -nopw -forever -shared > /tmp/vnc.log 2>&1 &
VNC_PID=$!
sleep 1

echo "✓ VNC Server gestartet (PID: $VNC_PID)"

# ===== SCHRITT 3: Starte noVNC Web Server =====
echo "[3/5] Starting noVNC Web Server..."
nohup websockify --web=/usr/share/novnc/ 6080 localhost:5900 > /tmp/novnc.log 2>&1 &
NOVNC_PID=$!
sleep 1

echo "✓ noVNC Web Server gestartet (PID: $NOVNC_PID)"
echo "  → Zugreifbar unter: http://localhost:6080/vnc.html"

# ===== SCHRITT 4: Starte Desktop Environment =====
echo "[4/5] Starting XFCE Desktop Environment..."
nohup startxfce4 > /tmp/xfce4.log 2>&1 &
XFCE_PID=$!
sleep 3  # Gib XFCE Zeit zu starten

echo "✓ XFCE Desktop gestartet (PID: $XFCE_PID)"

# ===== SCHRITT 5: Baue und installiere die SDL3 App =====
echo "[5/5] Building SDL3 Application..."

# Gehe ins Projekt-Verzeichnis
cd /workspaces/Test

# Initialisiere Git Submodule (WICHTIG!)
echo "  → Initializing SDL3 submodule..."
git submodule update --init --recursive > /dev/null 2>&1
echo "  ✓ SDL3 submodule initialized"

# Erstelle Build-Verzeichnis
echo "  → Creating build directory..."
rm -rf build
mkdir -p build
cd build

# CMake & Make
echo "  → Running CMake..."
cmake .. > /dev/null 2>&1

echo "  → Building application..."
make > /dev/null 2>&1

# Kopiere Executable zum Desktop
echo "  → Installing to desktop..."
if [ -f "app" ]; then
    cp app /root/Desktop/main
    chmod +x /root/Desktop/main
    echo "✓ Application installed to /root/Desktop/main"
else
    echo "✗ Build failed - executable not found"
    exit 1
fi

cd /workspaces/Test

# ===== SCHRITT 6: Erstelle Desktop Shortcut/Launcher =====
echo ""
echo "Creating desktop launcher..."

# Erstelle einen .desktop Launcher für das Programm
cat > /root/Desktop/SDL3App.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=SDL3 Application
Comment=Run SDL3 Application
Exec=/root/Desktop/main
Icon=application-x-executable
Categories=Utility;
Terminal=true
EOF

chmod +x /root/Desktop/SDL3App.desktop
echo "✓ Desktop Launcher erstellt"

# ===== Setup abgeschlossen =====
echo ""
echo "╔════════════════════════════════════════════╗"
echo "║   ✓ Setup abgeschlossen!                 ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "📍 Zugriffsdetails:"
echo "  • noVNC URL: http://localhost:6080/vnc.html"
echo "  • Display: :1"
echo "  • VNC: localhost:5900"
echo ""
echo "🖥️  Auf dem Desktop findest du:"
echo "  • main (die ausführbare Datei)"
echo "  • SDL3App.desktop (Launcher)"
echo ""
echo "💡 Tipps:"
echo "  • Öffne noVNC im Browser: http://localhost:6080/vnc.html"
echo "  • Doppelklick auf 'main' oder 'SDL3App.desktop' um zu starten"
echo "  • Die App fragt nach Text-Input im Terminal-Fenster"
echo "  • Output wird zu /workspaces/Test/data/output.txt geschrieben"
echo ""

# Halte den Container am Leben
echo "Setup erledigt. Container läuft..."
tail -f /dev/null