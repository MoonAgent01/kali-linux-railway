#!/bin/bash

# Fix shared memory — Kasm needs 512MB, Railway default is 64MB
mount -t tmpfs -o size=512m tmpfs /dev/shm 2>/dev/null || true

# Start nginx on port 8080 (HTTP -> HTTPS proxy to KasmVNC on 6901)
nginx

# Start KasmVNC desktop on default port 6901 (HTTPS)
# Kasm scripts handle the user switch to kasm-user internally
exec /dockerstartup/kasm_default_profile.sh /dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh --tail-log
