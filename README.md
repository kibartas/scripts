# Scripts that I use for my Arch Linux machine

## This currently includes:

- This script is deprecated ~~status_bar.sh - A script for dwm (dynamic window manager by suckless) that creates a status bar with relevant information for me using `xsetroot -name` command. I have the color patch for dwm status bar installed, so this won't work without the patch (or the color stuff can just be removed)~~</li>

### Scripts for [dwmblocks](https://github.com/torrinfail/dwmblocks) (which in turn is for [dwm](https://dwm.suckless.org/) in and of itself):
#### Some of these scripts use the dwm status2d patch syntax for color
- audio_status.sh - outputs information about master audio volume and master mute status</li>
- backlight_status.sh - outputs information about the backlight brightness (percentage)
- battery_status.sh - outputs information about the battery (color coded when charging or low (<= 20%). Percentage of battery left and whether it's charging or discharging (shown by an arrow icon)</li>
- layout_status.sh - outputs information about current keyboard layout (uses [xkblayout-state](https://github.com/nonpop/xkblayout-state) to determine the current layout)
- network_status.sh - outputs information on system's connection to wireless. If wireless connection exists it the system's IPv4 (NAT) and SSID in the format of `IP @ SSID`
- partition_status.sh - outputs information about space left on my Linux partition
- timer_status.sh - outputs timer info. Can be used standalone but one should then comment the `pkill` line near the end of the loop. Great with dwm and dwmblocks

#### All of these scripts can be used with dwmblocks out of the box (except `layout_status.sh`) but they can also be used standalone (you'd just have to remove the color stuff)

#### I write my scripts so that they affirm to [POSIX](https://en.wikipedia.org/wiki/POSIX) and I use [dash](http://gondor.apana.org.au/~herbert/dash/) as my script interpreter
