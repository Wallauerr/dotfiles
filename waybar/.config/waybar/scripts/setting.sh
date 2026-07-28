#!/usr/bin/env bash

DIR="$HOME/.config/waybar/scripts"

menu() {
    local prompt="$1"
    local options="$2"
    echo -e "$options" | omarchy-launch-walker --dmenu -p "$prompt" --width 400 --maxheight 500
}

detect_terminal() {
    if command -v alacritty &>/dev/null; then
        echo "alacritty --class OmarchyFloatingTerm --title"
    elif command -v ghostty &>/dev/null; then
        echo "ghostty --title"
    elif command -v kitty &>/dev/null; then
        echo "kitty --title"
    elif command -v foot &>/dev/null; then
        echo "foot -T"
    else
        notify-send "Error" "No terminal found!"
        exit 1
    fi
}

options="🎨 Theme\n🔤 Font\n🌙 Night Light\n🖥️ Display\n⌨️ Keybindings\n📦 Install Packages"
chosen=$(menu "󱄅 Settings" "$options")
[[ -z "$chosen" ]] && exit 0

case "$chosen" in
    *"Theme"*) omarchy theme pick ;;
    *"Font"*) omarchy font pick ;;
    *"Night Light"*) omarchy toggle nightlight ;;
    *"Display"*) omarchy launch display ;;
    *"Keybindings"*) omarchy menu keybindings ;;
    *"Install Packages"*) omarchy launch floating-terminal-with-presentation omarchy-install ;;
esac
