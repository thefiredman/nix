#!/bin/sh

yabai -m rule --add app="^System" manage=off
yabai -m rule --add title='^Settings' manage=off
yabai -m rule --add app="^Software" manage=off
yabai -m rule --add app='Finder' manage=off
yabai -m rule --add app='Music' manage=off
yabai -m rule --add app="Stocks" manage=off
yabai -m rule --add app="Reminders" manage=off
yabai -m rule --add app="FaceTime" manage=off
yabai -m rule --add app="Stickies" manage=off
yabai -m rule --add app="Mail" manage=off
yabai -m rule --add app="Dictionary" manage=off
yabai -m rule --add app="QuickTime Player" manage=off
yabai -m rule --add app="App Store" manage=off
yabai -m rule --add app="Activity Monitor" manage=off
yabai -m rule --add app="Weather" manage=off
yabai -m rule --add title='Archive Utility' manage=off
yabai -m rule --add label="Calculator" app="Calculator" manage=off
yabai -m rule --add app="Messages" manage=off
yabai -m rule --add app="Mullvad VPN" manage=off sticky=off layer=above
yabai -m rule --add app="choose" manage=off
yabai -m rule --add can-resize="^false$" manage=off

# my game
yabai -m rule --add app="da^" manage=off

# DONT DELETE
# focus window after active space changes
yabai -m signal --add event=space_changed action="[ $(yabai -m query --windows --space | jq length) -eq 1 ] && yabai -m window --focus first"

# focus window after active display changes

# focus window when there are no more windows
yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
