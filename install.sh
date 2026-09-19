#!/bin/bash

set -e

REPO="https://raw.githubusercontent.com/Bob-Bobbinson-Bob/Free-Crossover-Trial/main"

APP_DIR="$HOME/Free Crossover"
PLIST="$HOME/Library/LaunchAgents/com.user.update-first-run.plist"
SCRIPT="$APP_DIR/update_first_run.py"
LABEL="com.user.update-first-run"

install() {
    echo
    echo "Installing Free Crossover..."
    echo

    mkdir -p "$APP_DIR"
    mkdir -p "$HOME/Library/LaunchAgents"

    echo "Downloading update_first_run.py..."
    curl -fsSL "$REPO/update_first_run.py" \
        -o "$SCRIPT"

    echo "Downloading LaunchAgent..."
    curl -fsSL "$REPO/com.user.update-first-run.plist" \
        -o "$PLIST"

    echo "Configuring username..."
    sed -i '' "s|/Users/yourusername|$HOME|g" "$PLIST"

    echo "Checking plist..."
    plutil -lint "$PLIST"

    echo "Loading LaunchAgent..."
    launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true
    launchctl bootstrap "gui/$(id -u)" "$PLIST"

    echo "Running update script..."
    python3 "$SCRIPT"

    echo
    echo "Installation complete."
}

uninstall() {
    echo
    echo "Uninstalling Free Crossover..."
    echo

    echo "Stopping LaunchAgent..."
    launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true

    echo "Removing files..."
    rm -f "$PLIST"
    rm -f "$SCRIPT"

    if [ -d "$APP_DIR" ]; then
        rmdir "$APP_DIR" 2>/dev/null || true
    fi

    echo
    echo "Uninstallation complete."
}

if [ -f "$PLIST" ] || [ -f "$SCRIPT" ]; then
    echo "Free Crossover is already installed."
    echo
    echo "1) Reinstall"
    echo "2) Uninstall"
    echo "3) Cancel"
    echo

    read -r -p "Choose an option [1-3]: " choice

    case "$choice" in
        1)
            install
            ;;
        2)
            uninstall
            ;;
        3)
            echo "Cancelled."
            ;;
        *)
            echo "Invalid choice."
            exit 1
            ;;
    esac
else
    install
fi
