# Base Codespaces Ubuntu image
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install build tools, SDL dependencies, VNC stack, lightweight desktop & terminal
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    xvfb \
    x11vnc \
    openbox \
    lxterminal \
    python3 \
    python3-websockify \
    wget \
    curl \
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
    && rm -rf /var/lib/apt/lists/*

# Download noVNC
RUN mkdir -p /opt/novnc && \
    wget -O /opt/novnc/latest.tar.gz https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz && \
    tar xzf /opt/novnc/latest.tar.gz --strip-components=1