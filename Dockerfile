FROM kasmweb/kali-rolling-desktop:1.18.0

USER root

# Install nginx to reverse proxy HTTP -> KasmVNC HTTPS
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Nginx config: accept HTTP on 8080, proxy to KasmVNC HTTPS on 6901
COPY nginx.conf /etc/nginx/nginx.conf

# Entrypoint: start KasmVNC + nginx
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER 1000

ENV VNC_PW=password

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
