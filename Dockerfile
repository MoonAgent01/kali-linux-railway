FROM kasmweb/kali-rolling-desktop:1.18.0

USER root

# Disable SSL in KasmVNC — Railway handles SSL at the edge, backend must be HTTP
RUN sed -i 's/use_ssl: true/use_ssl: false/g' /usr/share/kasmvnc/kasmvnc_defaults.yaml || true
RUN sed -i 's/use_ssl: true/use_ssl: false/g' /etc/kasmvnc/kasmvnc.yaml 2>/dev/null || true

# Also patch the vnc_startup script to not use SSL
RUN if grep -q "websockify" /dockerstartup/vnc_startup.sh; then \
      sed -i 's/--ssl-only//' /dockerstartup/vnc_startup.sh || true; \
      sed -i 's/--cert[= ][^ ]*//' /dockerstartup/vnc_startup.sh || true; \
    fi

USER 1000

ENV VNC_PW=password
ENV KASM_PORT=8080

EXPOSE 8080
