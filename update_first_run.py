#!/usr/bin/env python3
import plistlib
import datetime
from pathlib import Path
import shutil

# -----------------------#
#  UPDATE FirstRunDate   #
# -----------------------#

plist_path = Path.home() / "Library/Preferences/com.codeweavers.CrossOver.plist"
backup_plist = plist_path.with_suffix(".plist.bak")

if plist_path.exists():
    if not backup_plist.exists():
        shutil.copy(plist_path, backup_plist)

    with plist_path.open("rb") as f:
        plist_data = plistlib.load(f)

    current_date = datetime.datetime.utcnow()
    plist_data["FirstRunDate"] = current_date

    with plist_path.open("wb") as f:
        plistlib.dump(plist_data, f)

    print(f"Updated FirstRunDate to: {current_date.strftime('%Y-%m-%d %H:%M:%S +0000')}")
else:
    print("CrossOver plist not found, skipping FirstRunDate update")


# -----------------------#
#   CLEAN system.reg     #
# -----------------------#

TARGET = "Software\\\\CodeWeavers\\\\CrossOver\\\\cxoffice"
bottles_dir = Path.home() / "Library/Application Support/CrossOver/Bottles"

if not bottles_dir.exists():
    print("Bottles directory not found")
    exit(0)

for bottle in bottles_dir.iterdir():
    if not bottle.is_dir():
        continue

    reg_path = bottle / "system.reg"

    if not reg_path.exists():
        continue

    backup_reg = reg_path.with_suffix(".bak")
    if not backup_reg.exists():
        shutil.copy(reg_path, backup_reg)

    with reg_path.open("r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()

    output_lines = []
    skip = 0
    removed = False

    for line in lines:
        if skip > 0:
            skip -= 1
            continue

        if TARGET in line:
            skip = 4
            removed = True
            continue

        output_lines.append(line)

    if removed:
        with reg_path.open("w", encoding="utf-8") as f:
            f.writelines(output_lines)
        print(f"Cleaned: {reg_path}")
    else:
        print(f"No cxoffice entry in: {reg_path}")
