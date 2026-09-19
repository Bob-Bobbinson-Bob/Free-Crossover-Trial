#!/bin/bash

set -e

REPO="https://raw.githubusercontent.com/Bob-Bobbinson-Bob/Free-Crossover-Trial/main"

APP_DIR="$HOME/Free Crossover"
PLIST_DIR="$HOME/Library/LaunchAgents"
PLIST="$PLIST_DIR/com.user.update-first-run.plist"

echo "Installing Free Crossover..."

mkdir -p "$APP_DIR"
mkdir -p "$PLIST_DIR"

echo "Downloading Python script..."
curl -fsSL "$REPO/update_first_run.py" \
    -o "$APP_DIR/update_first_run.py"

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
python3 "$APP_DIR/update_first_run.py"

echo
echo "Free Crossover has been installed and started."
