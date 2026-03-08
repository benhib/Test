FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# Update und grundlegende Tools
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    pkg-config

# SDL3 Dependencies
RUN apt-get install -y \
    libx11-dev \
    libxext-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev \
    libxfixes-dev \
    libxss-dev \
    libxtst-dev \
    libwayland-dev \
    libxkbcommon-dev \
    libdbus-1-dev \
    libudev-dev \
    libgl1-mesa-dev \
    libasound2-dev

# Desktop Environment (XFCE)
RUN apt-get install -y \
    xfce4 \
    xfce4-terminal \
    xfce4-whiskermenu-plugin

# Virtual Display und VNC
RUN apt-get install -y \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    x11-xkb-utils \
    dbus-x11

# Zusätzliche Tools
RUN apt-get install -y \
    wget \
    curl \
    nano \
    htop

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Setze Workdir
WORKDIR /workspaces/Test

# Kopiere post-create script
COPY .devcontainer/post-create.sh /post-create.sh
RUN chmod +x /post-create.sh

# Desktop-Verzeichnis vorbereiten
RUN mkdir -p /root/Desktop && chmod 755 /root/Desktop

# Start script
CMD ["/post-create.sh"]