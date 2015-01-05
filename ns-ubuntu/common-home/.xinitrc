#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Merge X resources. This is what determines urxvt's color scheme.
if [ -f ~/.Xresources ]; then
  if type xrdb 2>/dev/null; then
    xrdb -merge ~/.Xresources
  fi
fi

# We shouldn't be used xmodmap anymore. We should use the xkb
# X11 extension to process keyboard inputs.
# Note: Information regarding available options can be found
#       in a file named base.lst (/usr/share/X11/xkb/rules)
# See: https://wiki.archlinux.org/index.php/X_KeyBoard_extension
#setxkbmap dvorak -option 'caps:swapescape,ctrl:swap_rwin_rctl'
# NOTE: For ubuntu, we will have to manually execute a modified

if [ -s ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

if [ -s ~/.xbindkeys ]; then
  xbindkeys
fi

# TODO: Take GPG agent from arch install.

# Ctrl-t and up / down / right / left equivalents are set up in
# the window manager.
exec i3
#exec xterm
