FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# Update and install Kali desktop (XFCE - lightweight) + VNC + noVNC
RUN apt-get update && apt-get install -y \
    kali-desktop-xfce \
    tightvncserver \
    novnc \
    websockify \
    dbus-x11 \
    xfonts-base \
    x11-xserver-utils \
    sudo \
    curl \
    wget \
    net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash kali && \
    echo "kali:kali" | chpasswd && \
    adduser kali sudo && \
    echo "kali ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER kali
WORKDIR /home/kali

# Set up VNC
RUN mkdir -p /home/kali/.vnc && \
    echo "kali" | vncpasswd -f > /home/kali/.vnc/passwd && \
    chmod 600 /home/kali/.vnc/passwd

# VNC startup script (XFCE session)
RUN echo '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &' > /home/kali/.vnc/xstartup && \
    chmod +x /home/kali/.vnc/xstartup

# Copy and set up the entrypoint
COPY --chown=kali:kali start.sh /home/kali/start.sh
RUN chmod +x /home/kali/start.sh

# Railway uses PORT env variable; noVNC will listen on it
EXPOSE ${PORT:-6080}

CMD ["/home/kali/start.sh"]
