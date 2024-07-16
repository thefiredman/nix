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
yabai -m rule --add app="Godot" manage=off
yabai -m rule --add app="^da" manage=off
yabai -m rule --add app="Mullvad VPN" manage=off sticky=off layer=above
yabai -m rule --add app="choose" manage=off
yabai -m rule --add can-resize="^false$" manage=off

# DONT DELETE
# focus window after active space changes
yabai -m signal --add event=space_changed action="yabai -m window --focus \$(yabai -m query --windows --space | jq .[0].id)"

# focus window after active display changes
yabai -m signal --add event=display_changed action="yabai -m window --focus \$(yabai -m query --windows --space | jq .[0].id)"

