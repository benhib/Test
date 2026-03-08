FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-terminal \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    git \
    cmake \
    build-essential \
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

WORKDIR /workspace

COPY start-desktop.sh /start-desktop.sh
RUN chmod +x /start-desktop.sh

CMD ["/start-desktop.sh"]