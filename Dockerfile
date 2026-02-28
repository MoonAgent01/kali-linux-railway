FROM kasmweb/kali-rolling-desktop:1.18.0

USER root

# Set VNC password and disable basic auth for browser access
ENV VNC_PW=password
ENV VNCOPTIONS="-disableBasicAuth"
ENV KASM_PORT=6901

# Configure KasmVNC to use HTTP (not HTTPS) since Railway handles SSL
RUN sed -i 's/use_ssl: true/use_ssl: false/' /etc/kasmvnc/kasmvnc.yaml || true
RUN if [ -f /usr/share/kasmvnc/kasmvnc_defaults.yaml ]; then \
      sed -i 's/use_ssl: true/use_ssl: false/' /usr/share/kasmvnc/kasmvnc_defaults.yaml; \
    fi

USER 1000

EXPOSE 6901
