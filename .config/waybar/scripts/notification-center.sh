#!/bin/bash

# Notification Center Script for Waybar
# Displays current media and recent dunst notifications

DUNST_HISTORY_FILE="$HOME/.cache/dunst/history"
NOTIFICATION_CACHE="$HOME/.cache/waybar_notifications"

# Ensure cache directory exists
mkdir -p "$HOME/.cache/waybar_notifications"

# Function to format time ago
format_time_ago() {
    local timestamp=$1
    local now=$(date +%s)
    local diff=$((now - timestamp))
    
    if [ $diff -lt 60 ]; then
        echo "${diff}s ago"
    elif [ $diff -lt 3600 ]; then
        echo "$((diff / 60))m ago"
    else
        echo "$((diff / 3600))h ago"
    fi
}

# Function to get current media info
get_media_info() {
    if ! command -v playerctl &> /dev/null; then
        return
    fi
    
    # Check if any player is running
    if ! playerctl status &> /dev/null; then
        return
    fi
    
    local status=$(playerctl status 2>/dev/null)
    local player=$(playerctl -l 2>/dev/null | head -1)
    local title=$(playerctl metadata title 2>/dev/null)
    local artist=$(playerctl metadata artist 2>/dev/null)
    
    if [ -z "$title" ]; then
        return
    fi
    
    # Get position and length
    local position=$(playerctl position 2>/dev/null)
    local length=$(playerctl metadata mpris:length 2>/dev/null)
    
    # Convert to seconds (position is in microseconds)
    if [ ! -z "$position" ] && [ ! -z "$length" ]; then
        position=$(printf "%.0f" $(echo "$position" | awk '{print int($1/1000000)}'))
        length=$(printf "%.0f" $(echo "$length" | awk '{print int($1/1000000)}'))
        
        if [ $length -gt 0 ]; then
            local progress=$((position * 100 / length))
        else
            local progress=0
        fi
    else
        local progress=0
    fi
    
    # Format times
    local pos_min=$((position / 60))
    local pos_sec=$((position % 60))
    local len_min=$((length / 60))
    local len_sec=$((length % 60))
    
    # Format output
    printf '{"media":{"status":"%s","player":"%s","title":"%s","artist":"%s","progress":%d,"position":"%02d:%02d","length":"%02d:%02d"}' \
        "$status" "$player" "$title" "$artist" "$progress" "$pos_min" "$pos_sec" "$len_min" "$len_sec"
}

# Function to get recent notifications from dunst
get_notifications() {
    local notifications="[]"
    
    if [ ! -f "$DUNST_HISTORY_FILE" ]; then
        echo "$notifications"
        return
    fi
    
    # Read dunst history and extract last 10 notifications
    # Dunst history format: timestamp <tab> urgency <tab> appname <tab> summary <tab> body <tab> icon
    local count=0
    local notif_array="["
    local first=true
    
    # Reverse order to get most recent first
    tac "$DUNST_HISTORY_FILE" 2>/dev/null | while IFS=$'\t' read -r timestamp urgency appname summary body icon; do
        if [ $count -ge 10 ]; then
            break
        fi
        
        # Skip invalid lines
        if [ -z "$timestamp" ] || [ -z "$appname" ]; then
            continue
        fi
        
        # Remove quotes if present
        summary="${summary%\"}"
        summary="${summary#\"}"
        body="${body%\"}"
        body="${body#\"}"
        appname="${appname%\"}"
        appname="${appname#\"}"
        
        # Escape JSON strings
        summary=$(printf '%s\n' "$summary" | jq -Rs .)
        body=$(printf '%s\n' "$body" | jq -Rs .)
        appname=$(printf '%s\n' "$appname" | jq -Rs .)
        
        if [ "$first" = true ]; then
            first=false
            notif_array+="{"
        else
            notif_array+=",$NEWLINE{"
        fi
        
        notif_array+="\"timestamp\":$timestamp,\"urgency\":\"$urgency\",\"app\":$appname,\"summary\":$summary,\"body\":$body}"
        
        count=$((count + 1))
    done
    
    notif_array+="]"
    echo "$notif_array"
}

# Main output
output='{'

# Get media info
media_info=$(get_media_info)
if [ ! -z "$media_info" ]; then
    output+="$media_info,"
else
    output+='{"media":null},'
fi

# Get notifications
output+="\"notifications\":$(get_notifications)"
output+='}'

echo "$output" | jq '.' 2>/dev/null || echo '{"media":null,"notifications":[]}'
