#!/bin/bash
set -e

# Increase shared memory if possible
if mount | grep -q "/dev/shm"; then
    mount -o remount,size=512m /dev/shm 2>/dev/null || true
fi

# Railway sets PORT env var — if set, configure KasmVNC to use it
if [ -n "$PORT" ] && [ "$PORT" != "6901" ]; then
    # Update KasmVNC config to listen on Railway's PORT instead of 6901
    export KASM_PORT=$PORT
    find / -name "*.yaml" -path "*/kasmvnc/*" -exec sed -i "s/default_port: 6901/default_port: $PORT/g" {} \; 2>/dev/null || true
fi

# Execute the original Kasm startup
exec /dockerstartup/kasm_default_profile.sh /dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh --tail-log
