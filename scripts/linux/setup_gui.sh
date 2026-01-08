#!/bin/bash
# AeonDesk GUI Setup Script
# This runs inside the Linux environment on the first launch

echo "Initializing AeonDesk Environment..."

# Update packages
apt update && apt upgrade -y

# Install XFCE4 and essentials
apt install -y xfce4 xfce4-terminal dbus-x11 git wget neofetch

# Setup VNC/X11 password or configs here
# (Since we use embedded X11, VNC might not be needed depending on implementation)

# Create a startup script
echo "startxfce4" > /usr/bin/aeon-desktop
chmod +x /usr/bin/aeon-desktop

echo "AeonDesk Setup Complete!"
