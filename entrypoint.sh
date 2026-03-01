#!/bin/bash

# Start nginx on port 8080 (HTTP -> HTTPS proxy to KasmVNC on 6901)
nginx &

# Start KasmVNC desktop on default port 6901 (HTTPS)
/dockerstartup/kasm_default_profile.sh /dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh --tail-log
