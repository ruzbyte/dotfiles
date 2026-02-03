#!/bin/bash

echo "--- 1. Laufende Portal-Prozesse ---"
ps aux | grep -v grep | grep xdg-desktop-portal

echo -e "\n--- 2. Installierte Portal-Pakete (Arch/Pacman-basiert) ---"
# Falls du Debian/Ubuntu nutzt, ersetze 'pacman -Qs' durch 'dpkg -l | grep'
pacman -Qs xdg-desktop-portal | grep local

echo -e "\n--- 3. Aktive D-Bus Schnittstelle für Screenshare ---"
dbus-send --print-reply --dest=org.freedesktop.portal.Desktop \
    /org/freedesktop/portal/desktop org.freedesktop.DBus.Introspectable.Introspect | grep -oE 'org.freedesktop.impl.portal.ScreenCast.[a-zA-Z]+'

echo -e "\n--- 4. Umgebungsvariablen ---"
echo "XDG_CURRENT_DESKTOP: $XDG_CURRENT_DESKTOP"
echo "WAYLAND_DISPLAY: $WAYLAND_DISPLAY"
