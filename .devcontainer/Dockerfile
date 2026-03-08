FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Build tools + SDL dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git wget xvfb \
    libx11-dev libxext-dev libxrandr-dev libxinerama-dev \
    libxcursor-dev libxi-dev libxfixes-dev libxss-dev libxtst-dev \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC headless GUI
RUN apt-get install -y python3-websockify novnc && \
    rm -rf /var/lib/apt/lists/*

# Set SDL to run in offscreen mode (no X needed)
ENV SDL_VIDEODRIVER=offscreen