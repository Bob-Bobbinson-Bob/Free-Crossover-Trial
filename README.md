# Disclaimer

This software is for EDUCATIONAL PURPOSES ONLY!!!! Please support the official release of CrossOver.

Please use this software at your own risk. I have tested it on 2 Macs and it appears to fully function on both of them, so it should work, but still.

# What this contains

This contains a Python file that allows you to use CrossOver for free by renewing your CrossOver trial, and a plist file that can be set up to run whenever you boot up your Mac, renewing your license whenever you turn it on. No malicious code or anything bad!

If you want to run this command whenever your Mac starts up, then scroll down to the 'Running on Startup' section, else go to the 'Simple Usage' section.

# Simple Usage

Run this Python file to renew your CrossOver trial.

To renew the trial:

1. Download the Python file from the releases tab.
2. Run this code, changing the path/to/ bit to wherever you put your Python file:

```python3
python3 path/to/update_first_run.py

```

Your CrossOver trial should now be reset.

# Running on Startup

This is a bit more complex to set up, but still isn't THAT hard, it just takes more time.

To do this:

1. Download the Python file and the plist file from the releases tab.
2. Put the Python file in the '/Users/yourusername/Free Crossover' directory (if the 'Free Crossover' folder doesn't exist then create it). We are done with the Python file now.
3. Open the plist file with a text editor (NOT a prefs editor).
4. On line 12 of the plist file replace 'yourusername' with your actual username.
5. Save this and close the text editor.
6. In order to make this run on startup, move this to the '/Users/yourusername/Library/LaunchAgents' directory. NOTE: The Library may not be visible in Finder. In order to access it, either press Cmd+Shift+. to show all hidden files OR on the menu bar, select 'Go' then hold down the option key to show the Library directory, which can be entered.

Now whenever you reboot your Mac your CrossOver trial SHOULD be reset.
