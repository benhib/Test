# Use official Ubuntu base for devcontainers
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install build tools, SDL dependencies, and Xvfb
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    xvfb \
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