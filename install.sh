#!/bin/bash

set -e

REPO="https://raw.githubusercontent.com/Bob-Bobbinson-Bob/Free-Crossover-Trial/main"

APP_DIR="$HOME/Free Crossover"
PLIST_DIR="$HOME/Library/LaunchAgents"
PLIST="$PLIST_DIR/com.user.update-first-run.plist"
SCRIPT="$APP_DIR/update_first_run.py"

LABEL="com.user.update-first-run"
DOMAIN="gui/$(id -u)"

GRAY='\033[90m'
RED='\033[31m'
GREEN='\033[32m'
RESET='\033[0m'

is_installed() {
    [ -f "$SCRIPT" ] || [ -f "$PLIST" ] || launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1
}

install() {
    echo
    echo "Installing Free Crossover..."
    echo

    mkdir -p "$APP_DIR"
    mkdir -p "$PLIST_DIR"

    echo "Downloading update_first_run.py..."
    curl -fsSL "$REPO/update_first_run.py" -o "$SCRIPT"

    echo "Downloading LaunchAgent..."
    curl -fsSL "$REPO/com.user.update-first-run.plist" -o "$PLIST"

    echo "Configuring username..."
    sed -i '' "s|/Users/yourusername|$HOME|g" "$PLIST"

    echo "Checking plist..."
    plutil -lint "$PLIST"

    echo "Loading LaunchAgent..."
    launchctl bootout "$DOMAIN" "$PLIST" 2>/dev/null || true
    launchctl bootstrap "$DOMAIN" "$PLIST"

    if ! launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
        echo
        echo -e "${RED}Installation failed: LaunchAgent was not loaded.${RESET}"
        return 1
    fi

    echo "Running update script..."
    python3 "$SCRIPT"

    echo
    echo -e "${GREEN}Installation complete.${RESET}"
}

uninstall() {
    echo
    echo "Uninstalling Free Crossover..."
    echo

    echo "Stopping LaunchAgent..."
    launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true

    echo "Removing files..."
    rm -f "$PLIST"
    rm -f "$SCRIPT"

    rmdir "$APP_DIR" 2>/dev/null || true

    echo
    echo -e "${GREEN}Uninstallation complete.${RESET}"
}

while true; do
    clear

    echo "================================"
    echo "       Free Crossover"
    echo "================================"
    echo

    echo "  1) Install / Reinstall (Also runs trial reset script)"

    if is_installed; then
        echo -e "  2) ${RED}Uninstall${RESET}"
    else
        echo -e "  2) ${GRAY}Uninstall${RESET}"
    fi

    echo "  3) Exit to Terminal"
    echo

    read -r -p "Choose an option [1-3]: " choice

    case "$choice" in
        1)
            install
            echo
            read -r -p "Press Enter to return to the menu..."
            ;;
        2)
            if is_installed; then
                uninstall
                echo
                read -r -p "Press Enter to return to the menu..."
            else
                echo
                echo -e "${GRAY}Uninstall is unavailable because Free Crossover is not installed.${RESET}"
                echo
                read -r -p "Press Enter to return to the menu..."
            fi
            ;;
        3)
            clear
            exit 0
            ;;
        *)
            echo
            echo "Invalid option."
            echo
            read -r -p "Press Enter to return to the menu..."
            ;;
    esac
done
