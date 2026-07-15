#!/bin/bash

set -e

export USER=desktop
export HOME=/home/desktop
export DISPLAY=:1
export VNC_RESOLUTION=${VNC_RESOLUTION:-1366x768}
export TZ=${TZ:-UTC}
export PORT=${PORT:-6080}

mkdir -p "$HOME/.vnc"

chown -R desktop:desktop "$HOME"

# Remove stale locks
rm -rf /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1

# Create xstartup
cat > "$HOME/.vnc/xstartup" <<'EOF'
#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

xrdb $HOME/.Xresources

# Disable screen blanking
xset s off
xset s noblank
xset -dpms

# Disable XFCE compositor for better performance
xfconf-query -c xfwm4 -p /general/use_compositing -s false 2>/dev/null || true

exec startxfce4
EOF

chmod +x "$HOME/.vnc/xstartup"
chown desktop:desktop "$HOME/.vnc/xstartup"

# Kill previous VNC session if it exists
su - desktop -c "vncserver -kill :1" >/dev/null 2>&1 || true

# Start PulseAudio
su - desktop -c "pulseaudio --start --exit-idle-time=-1" >/dev/null 2>&1 || true

# Start VNC
su - desktop -c "vncserver :1 \
    -geometry ${VNC_RESOLUTION} \
    -depth 24 \
    -localhost no"

# Start noVNC
/usr/share/novnc/utils/novnc_proxy \
    --listen ${PORT} \
    --vnc localhost:5901 &

echo ""
echo "=========================================="
echo " Ubuntu Desktop Started"
echo "=========================================="
echo "Web Desktop : http://localhost:${PORT}/vnc.html"
echo "VNC Port    : 5901"
echo "Resolution  : ${VNC_RESOLUTION}"
echo "=========================================="

tail -F /home/desktop/.vnc/*.log
