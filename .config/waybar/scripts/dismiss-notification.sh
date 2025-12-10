#!/bin/bash

# Script to handle notification dismissal
# Usage: dismiss-notification.sh <timestamp>

DUNST_HISTORY_FILE="$HOME/.cache/dunst/history"

if [ -z "$1" ]; then
    exit 1
fi

TIMESTAMP="$1"

# Create a temporary file without the notification
if [ -f "$DUNST_HISTORY_FILE" ]; then
    grep -v "^${TIMESTAMP}" "$DUNST_HISTORY_FILE" > "${DUNST_HISTORY_FILE}.tmp"
    mv "${DUNST_HISTORY_FILE}.tmp" "$DUNST_HISTORY_FILE"
fi

# Trigger waybar update
pkill -SIGRTMIN+8 waybar 2>/dev/null
