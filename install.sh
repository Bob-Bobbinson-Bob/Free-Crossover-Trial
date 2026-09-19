#!/bin/bash

set -e

REPO="https://raw.githubusercontent.com/Bob-Bobbinson-Bob/Free-Crossover-Trial/main"

mkdir -p "$HOME/Free Crossover"
mkdir -p "$HOME/Library/LaunchAgents"

curl -fsSL "$REPO/update_first_run.py" \
    -o "$HOME/Free Crossover/update_first_run.py"

curl -fsSL "$REPO/com.user.update-first-run.plist" \
    -o "$HOME/Library/LaunchAgents/com.user.update-first-run.plist"

sed -i '' "s|/Users/yourusername|$HOME|g" \
    "$HOME/Library/LaunchAgents/com.user.update-first-run.plist"

plutil -lint "$HOME/Library/LaunchAgents/com.user.update-first-run.plist"

launchctl bootout gui/$(id -u) \
    "$HOME/Library/LaunchAgents/com.user.update-first-run.plist" 2>/dev/null || true

launchctl bootstrap gui/$(id -u) \
    "$HOME/Library/LaunchAgents/com.user.update-first-run.plist"

echo "Free Crossover startup setup complete."
