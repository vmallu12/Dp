FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV VNC_RESOLUTION=1366x768
ENV TZ=UTC

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tigervnc-standalone-server \
    novnc \
    websockify \
    dbus-x11 \
    x11-xserver-utils \
    x11-utils \
    xterm \
    firefox \
    pulseaudio \
    pavucontrol \
    sudo \
    curl \
    wget \
    git \
    nano \
    ca-certificates \
    fonts-dejavu \
    fonts-liberation \
    supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash desktop && \
    echo "desktop ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir -p /home/desktop/.vnc && \
    chown -R desktop:desktop /home/desktop

COPY start.sh /start.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /start.sh

EXPOSE 6080
EXPOSE 5901

HEALTHCHECK CMD pgrep Xtigervnc || exit 1

CMD ["/start.sh"]
