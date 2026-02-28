FROM kasmweb/kali-rolling-desktop:1.18.0

USER root

# Railway doesn't support --shm-size, so increase shm inside the image
RUN umount /dev/shm 2>/dev/null; rm -rf /dev/shm && mkdir -p /dev/shm && chmod 1777 /dev/shm

# Generate self-signed cert for KasmVNC (it expects SSL certs to exist)
RUN openssl req -x509 -nodes -days 3650 \
    -newkey rsa:2048 \
    -keyout /usr/share/kasmvnc/certs/self.pem \
    -out /usr/share/kasmvnc/certs/self.pem \
    -subj "/C=US/ST=None/L=None/O=None/CN=localhost" 2>/dev/null || true

# VNC password and settings
ENV VNC_PW=password

# Tell Kasm to listen on port 6901
ENV KASM_PORT=6901

USER 1000

EXPOSE 6901
