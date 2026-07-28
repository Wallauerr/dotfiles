#!/bin/bash

# --- CONFIGURATION - Colors from theme ---
COLORS_FILE=~/.config/omarchy/current/theme/colors.toml

read_toml_color() {
    local key=$1
    grep -m1 "^${key} =" "$COLORS_FILE" 2>/dev/null | sed 's/.*= *"#\?\([^"]*\)".*/\1/'
}

COLOR_BARS="#$(read_toml_color orange)"
COLOR_TITLE="#$(read_toml_color cyan)"
COLOR_ARTIST="#$(read_toml_color magenta)"

# Redirect all errors to /dev/null so they don't show on screen
exec 2>/dev/null

# 1. Get the active player
get_active_player() {
    local player=$(playerctl --list-all | while read -r p; do
        if [ "$(playerctl -p "$p" status 2>/dev/null)" = "Playing" ]; then
            echo "$p"
            exit 0
        fi
    done)
    # If no player is playing, just get the first one available
    echo "${player:-$(playerctl --list-all | head -1)}"
}

# 2. Clean text for Hyprlock (Pango Markup)
sanitize() {
    local str="$1"
    # Essential: Escape characters that break Pango
    str="${str//&/&amp;}"
    str="${str//</&lt;}"
    str="${str//>/&gt;}"
    str="${str//\"/&quot;}"
    str="${str//\'/&apos;}"
    echo -n "$str"
}

# 3. Big Symmetrical Animation
get_bars() {
    local player=$(get_active_player)
    [ -z "$player" ] && return
    
    local status=$(playerctl -p "$player" status 2>/dev/null)
    if [ "$status" = "Playing" ]; then
        local t=$(( $(date +%s%N) / 200000000 )) 
        local frame=$(( t % 4 ))
        case $frame in
            0) local b="▃ ▆ █ ▆" ;;
            1) local b="▆ █ ▆ ▃" ;;
            2) local b="█ ▆ ▃ ▆" ;;
            3) local b="▆ ▃ ▆ █" ;;
        esac
        echo -n "<span size='large' color='$COLOR_BARS'>$b</span>"
    else
        echo -n "<span size='large' color='$COLOR_BARS'>󰏤</span>"
    fi
}

# 4. The Music Name and Artist
get_music_info() {
    local player=$(get_active_player)
    
    if [ -z "$player" ]; then
        echo -n "󰎆  Silence"
        return
    fi

    local status=$(playerctl -p "$player" status 2>/dev/null)
    if [ "$status" != "Playing" ]; then
        echo -n "󰎆  Silence"
        return
    fi

    local title=$(playerctl -p "$player" metadata --format "{{title}}" 2>/dev/null)
    local artist=$(playerctl -p "$player" metadata --format "{{artist}}" 2>/dev/null)

    [ -z "$title" ] && title="Unknown Track"
    [ -z "$artist" ] && artist="Unknown Artist"

    [ ${#title} -gt 25 ] && title="${title:0:22}..."
    [ ${#artist} -gt 20 ] && artist="${artist:0:17}..."

    local c_title=$(sanitize "$title")
    local c_artist=$(sanitize "$artist")

    echo -n "<span weight='bold' color='$COLOR_TITLE'>$c_title</span> <span color='$COLOR_ARTIST'>by $c_artist</span>"
}

# --- MAIN OUTPUT ---
# Check if playerctl can even see a player
if ! playerctl status &>/dev/null; then
    echo "󰎆  Silence"
else
    # Combine BARS + INFO + BARS
    BARS=$(get_bars)
    INFO=$(get_music_info)
    echo -e "${BARS}   ${INFO}   ${BARS}"
fi
