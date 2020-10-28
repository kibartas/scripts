# Scripts that I use for my Arch Linux machine

## This currently includes:

- This script is deprecated ~~status_bar.sh - A script for dwm (dynamic window manager by suckless) that creates a status bar with relevant information for me using `xsetroot -name` command. I have the color patch for dwm status bar installed, so this won't work without the patch (or the color stuff can just be removed)~~</li>

### Scripts for [dwmblocks](https://github.com/torrinfail/dwmblocks) (which in turn is for [dwm](https://dwm.suckless.org/) in and of itself):
#### Some of these scripts use the dwm status2d patch syntax for color
- audio_status.sh - outputs information about master audio volume and master mute status (2020-10-28: Also added microphone info to the same script)
- backlight_status.sh - outputs information about the backlight brightness (percentage)
- battery_status.sh - outputs information about the battery (color coded when charging or low (<= 20%). Percentage of battery left and whether it's charging or discharging (shown by an arrow icon)
- layout_status.sh - outputs information about current keyboard layout (uses [xkblayout-state](https://github.com/nonpop/xkblayout-state) to determine the current layout)
- network_status.sh - outputs information on system's connection to wireless. If wireless connection exists it outputs the system's IPv4 (private, obvs) and SSID in the format of `IP @ SSID`. #TODO: VPN (tun interface)
- partition_status.sh - outputs information about space left on my Linux partition
#### And the timer family:
- timer_status.sh - outputs timer info. Can be used standalone but one should then comment the `pkill` line near the end of the loop. Great with dwm and dwmblocks
- timer_util.sh - small timer_status.sh utility that kills it if it exists and runs it if it doesn't. (I made this so there could never be more than one timer_status.sh in the system. This is basically the interface through which timer_status.sh should be run)
- timer_log.sh - logs timer info to timer.log
- 
#### (dwmblocks only (works on root windows because of `xev -root`))
- timer_pick.sh - let's the user pick timer's from timer.log. Includes coloring for easy visibility. Up and down arrow keys to navigate and return to select. Green means current, yellow means from timer.log and white means that your selection has been accepted.
![timer_pick.gif](https://s8.gifyu.com/images/Timer_2-2020-10-17_20.13.34.gif)
- timer_name.sh - rename your script. 
![timer_name.gif](https://s2.gifyu.com/images/timer_name-2020-10-28_16.24.51.gif)

#### I write my scripts so that they affirm to [POSIX](https://en.wikipedia.org/wiki/POSIX) and I use [dash](http://gondor.apana.org.au/~herbert/dash/) as my shell interpreter
