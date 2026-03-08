FROM accetto/ubuntu-vnc-xfce-g3:latest

USER root

# Install build tools and SDL dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libsdl2-dev \
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

    USER 1000