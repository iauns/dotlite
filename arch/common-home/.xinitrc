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

# exec gnome-session
# exec startkde
# exec startxfce4
# exec xterm

# We shouldn't be used xmodmap anymore. We should use the xkb
# X11 extension to process keyboard inputs.
# Note: Information regarding available options can be found
#       in a file named base.lst (/usr/share/X11/xkb/rules)
# See: https://wiki.archlinux.org/index.php/X_KeyBoard_extension
setxkbmap dvorak -option 'caps:swapescape,ctrl:swap_rwin_rctl'

if [ -s ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

# Ctrl-t and up / down / right / left equivalents are set up in
# the window manager.
exec i3
#exec xterm
