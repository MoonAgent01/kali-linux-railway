FROM kasmweb/kali-rolling-desktop:1.18.0

USER root

# Fix shared memory — Kasm needs at least 512MB, Railway doesn't support --shm-size
RUN rm -rf /dev/shm && mkdir -p /dev/shm && chmod 1777 /dev/shm
RUN echo "tmpfs /dev/shm tmpfs defaults,size=512m 0 0" >> /etc/fstab

# Disable SSL — Railway handles SSL termination, KasmVNC must serve plain HTTP
RUN find / -name "*.yaml" -path "*/kasmvnc/*" -exec sed -i 's/use_ssl: true/use_ssl: false/g' {} \; 2>/dev/null || true

# Set VNC password
ENV VNC_PW=password
ENV VNCOPTIONS="-disableBasicAuth"

# Create custom startup that maps Railway's PORT to KasmVNC's port
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER 1000

EXPOSE 6901

ENTRYPOINT ["/entrypoint.sh"]
