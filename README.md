# Disclaimer

This software is for EDUCATIONAL PURPOSES ONLY!!!! Please support Codeweavers by buying the official release of CrossOver.

Please use this software at your own risk. I have tested it on 2 Macs and it appears to fully function on both of them, so it should work, but still.

Also, this is my first proper published repo, so sorry if it is annoying to set this up and slightly messy. Feel free to make an installer for this to make it easier to set up, and also feel free to upload the installer somewhere.

# What this contains

This contains an installer to get this all setup easily and quickly, a Python file that allows you to use CrossOver for free by renewing your CrossOver trial, and a plist file that can be set up to run whenever you boot up your Mac, renewing your license whenever you turn it on. No malicious code or anything bad!

If you want to run this command whenever your Mac starts up, then just do the 'EZ setup'. If you wanna do this setup manually for some reason then scroll down to the 'Manual setup section', then choose what you want to do from there on out.

# What you will need

Your Mac with Crossover and also Python 3.

# EZ setup

If you just wanna set this up easily with it working on every mac restart then run this command: 

```zsh
bash <(curl -fsSL https://raw.githubusercontent.com/Bob-Bobbinson-Bob/Free-Crossover-Trial/main/install.sh)
```

Then it should be reset and will always be reset whenever you turn your mac on.

# Manual setup

For some reason if you wanna set up the files yourself then here are the ways to do it there are 2 methods to do this.

## Simple Usage

Run this Python file to renew your CrossOver trial.

To renew the trial:

1. Download the Python file from the releases tab.
2. Run this code, changing the path/to/ bit to wherever you put your Python file:

```python3
python3 path/to/update_first_run.py

```

Your CrossOver trial should now be reset.

## Running on Startup

This is a bit more complex to set up, but still isn't THAT hard, it just takes more time.

To do this:

1. Download the Python file and the plist file from the releases tab.
2. Put the Python file in the '/Users/yourusername/Free Crossover' directory (Obviously replacing 'yourusername' with the name of your username folder) (if any folder like the 'Free Crossover' folder doesn't exist then create it). We are done with the Python file now.
3. Open the plist file with a text editor (NOT a prefs editor).
4. On line 11 of the plist file replace 'yourusername' with your actual mac username.
5. Save this and close the text editor.
6. Move this to the '/Users/yourusername/Library/LaunchAgents' directory. NOTE: The Library may not be visible in Finder. In order to access it, either press Cmd+Shift+. to show all hidden files OR on the menu bar, select 'Go' then hold down the option key to show the Library directory, which can be entered.
7. Now run either command a) or b) (you do not need to run them both this just activates the plist, and you only need to run it once).

   a) (macOS 10.15 or newer):

   ```zsh
   launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.user.update-first-run.plist
   
   ```
   
   b) (macOS 10.4 – 10.12, though still works on newer Macs):

   ```zsh
   launchctl load ~/Library/LaunchAgents/com.user.update-first-run.plist
   
   ```
   NOTE: If you ever edit your plist file, use either command c) or d) ONCE to load it:

   c) (macOS 10.15 or newer):

   ```zsh
   launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.update-first-run.plist 2>/dev/null
   launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.user.update-first-run.plist

   
   ```
   
   d) (macOS 10.4 – 10.12, though still works on newer macs):

   ```zsh
   launchctl unload ~/Library/LaunchAgents/com.user.update-first-run.plist
   launchctl load ~/Library/LaunchAgents/com.user.update-first-run.plist

   
   ```

Now whenever you reboot your Mac your CrossOver trial SHOULD be reset.
