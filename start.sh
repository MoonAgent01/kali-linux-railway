#!/bin/bash

# Use Railway's PORT env variable, default to 6080
PORT=${PORT:-6080}

# Remove stale VNC lock files
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Start VNC server on display :1 (port 5901)
vncserver :1 -geometry 1920x1080 -depth 24

# Start noVNC (websocket proxy) — connects to VNC on port 5901
# and exposes a web UI on $PORT
websockify --web=/usr/share/novnc/ $PORT localhost:5901

