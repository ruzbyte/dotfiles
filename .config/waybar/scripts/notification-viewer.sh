#!/bin/bash

# Rofi-based Notification Center Viewer
# Shows recent notifications and current media player status

DUNST_HISTORY_FILE="$HOME/.cache/dunst/history"
NOTIF_CACHE="/tmp/rofi_notifications.json"

# Get notification data
/home/zaroc/.config/waybar/scripts/notification-center.sh > "$NOTIF_CACHE" 2>/dev/null

# Build rofi menu
declare -a options
declare -a actions

# Add media section if available
if command -v playerctl &> /dev/null && playerctl status &> /dev/null 2>&1; then
    title=$(playerctl metadata title 2>/dev/null)
    artist=$(playerctl metadata artist 2>/dev/null)
    status=$(playerctl status 2>/dev/null)
    
    if [ ! -z "$title" ]; then
        options+=("♫ Now Playing")
        actions+=("media")
        
        options+=("  └─ $title")
        actions+=("info")
        
        if [ ! -z "$artist" ]; then
            options+=("  └─ by $artist")
            actions+=("info")
        fi
        
        # Control buttons
        options+=("")
        actions+=("sep")
        
        options+=("⏮ Previous")
        actions+=("playerctl previous")
        
        options+=("⏸ Play/Pause")
        actions+=("playerctl play-pause")
        
        options+=("⏭ Next")
        actions+=("playerctl next")
        
        options+=("")
        actions+=("sep")
    fi
fi

# Add notifications section
options+=("🔔 Recent Notifications")
actions+=("notif")

# Count notifications
if [ -f "$DUNST_HISTORY_FILE" ]; then
    notif_count=$(wc -l < "$DUNST_HISTORY_FILE")
else
    notif_count=0
fi

if [ $notif_count -gt 0 ]; then
    count=0
    tac "$DUNST_HISTORY_FILE" 2>/dev/null | while IFS=$'\t' read -r timestamp urgency appname summary body icon; do
        if [ $count -ge 10 ]; then
            break
        fi
        
        if [ -z "$timestamp" ] || [ -z "$appname" ]; then
            continue
        fi
        
        # Remove quotes
        summary="${summary%\"}"
        summary="${summary#\"}"
        appname="${appname%\"}"
        appname="${appname#\"}"
        
        # Truncate if too long
        if [ ${#summary} -gt 50 ]; then
            summary="${summary:0:47}..."
        fi
        
        options+=("  [$appname] $summary")
        actions+=("dismiss:$timestamp")
        
        count=$((count + 1))
    done
else
    options+=("  No notifications")
    actions+=("info")
fi

# Separator
options+=("")
actions+=("sep")

options+=("Clear All Notifications")
actions+=("clear-all")

# Display rofi menu
selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Notification Center" -theme-str 'window { width: 500px; }')

# Handle selection
if [ ! -z "$selected" ]; then
    # Find the index of selection
    for i in "${!options[@]}"; do
        if [ "${options[$i]}" = "$selected" ]; then
            action="${actions[$i]}"
            break
        fi
    done
    
    case "$action" in
        "media"|"info"|"sep"|"notif")
            # These are non-interactive
            ;;
        "clear-all")
            > "$DUNST_HISTORY_FILE"
            pkill -SIGRTMIN+8 waybar 2>/dev/null
            notify-send "Notifications cleared"
            ;;
        "dismiss:"*)
            timestamp="${action#dismiss:}"
            ~/.config/waybar/scripts/dismiss-notification.sh "$timestamp"
            notify-send "Notification dismissed"
            ;;
        "playerctl "*)
            bash -c "$action"
            ;;
    esac
fi
