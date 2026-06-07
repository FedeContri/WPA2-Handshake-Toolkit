#!/bin/bash

# This file was created to disable monitor mode and restore normal
# network connectivity while automatically detecting the active
# network management service.

# Detect the first monitor interface available on the system.
MON_IFACE=$(iw dev | awk '$1=="Interface" && $2 ~ /mon$/ {print $2; exit}')

# Verify that a monitor interface was found.
if [ -z "$MON_IFACE" ]; then
    echo "No monitor interface detected."
    exit 1
fi

# We stop monitor mode on the detected monitor interface and return
# the wireless adapter to its standard managed mode.
sudo airmon-ng stop "$MON_IFACE"

# Detect the active network management service.
if systemctl is-enabled NetworkManager >/dev/null 2>&1; then
    NET_SERVICE="NetworkManager"
elif systemctl is-enabled systemd-networkd >/dev/null 2>&1; then
    NET_SERVICE="systemd-networkd"
elif systemctl is-enabled networking >/dev/null 2>&1; then
    NET_SERVICE="networking"
else
    NET_SERVICE=""
fi

# Verify that a supported network management service was detected.
if [ -z "$NET_SERVICE" ]; then
    echo "No supported network management service detected."
    exit 1
fi

# We restart the detected network management service to restore
# normal network connectivity and network management functions.
sudo systemctl restart "$NET_SERVICE"

echo "Monitor mode disabled."
echo "Network service restarted: $NET_SERVICE"
