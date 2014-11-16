#!/bin/sh
# Most importantly, see: http://askubuntu.com/questions/24916/how-do-i-remap-certain-keys
# See: http://offend.me.uk/blog/14/
# See: http://www.in-ulm.de/~mascheck/X11/xmodmap.html
# See: http://cs.gmu.edu/~sean/stuff/n800/keyboard/old.html
# 
# http://www.in-ulm.de/~mascheck/X11/xmodmap.html

# Clear the logical modifiers
xmodmap -e "clear Shift"
xmodmap -e "clear Lock"
xmodmap -e "clear Control"
xmodmap -e "clear Mod1"
xmodmap -e "clear Mod2"
xmodmap -e "clear Mod3"
xmodmap -e "clear Mod4"
xmodmap -e "clear Mod5"

xmodmap -e "add shift = Shift_L Shift_R"
xmodmap -e "add control = Control_L Super_R"
xmodmap -e "add mod1 = Meta_L Meta_R"

# Clear caps lock then re-assign it to escape.
echo "caps lock to escape"
xmodmap -e "keycode 66 = Escape"

# # Change right command into control.
echo "Right command into control"
#xmodmap -e "add control = Super_R"
xmodmap -e "keycode 0x86 = Control_R"

# Now remap Left command to Mode_switch.
# We use Mode_switch as a general key to modify basic interaction.
echo "Left command to mode switch"
xmodmap -e "keycode 0x85 = Mode_switch"

# Remap Right command to Control
echo "Right command to control"
#xmodmap -e "keycode 0x86 = Control_R"

# All of the following can be done inside of i3.
# Make Mode_switch-T issue an 'enter'
echo "Mod_Sswitch-T to enter"
xmodmap -e "keycode 45 = t T Return Return"

# Keys for up and down.
echo "Up and down keys"
xmodmap -e "keycode 27 = p P Up Up"
xmodmap -e "keycode 41 = u U Down Down"
xmodmap -e "keycode 25 = comma less Left Left"
xmodmap -e "keycode 26 = period greater Right Right"
