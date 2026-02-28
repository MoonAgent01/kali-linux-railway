FROM kasmweb/kali-rolling-desktop:1.18.0

# Railway assigns a dynamic PORT — Kasm desktop listens on 6901 by default
# We set VNC_PW for the login password
ENV VNC_PW=password
ENV VNCOPTIONS="-disableBasicAuth"

# Expose the Kasm web UI port
EXPOSE 6901
