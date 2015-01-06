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
  else
    echo "xinitrc: Unable to find xrdb (pacman xorg-xrdb package)"
  fi
fi

# Disable touch pad if syndaemon is available.
#if type syndaemon 2>/dev/null; then
#  # -i 2 == Sets idle time (time after each keypress to re-enable taps).
#  # -k   == Ignore modifier keys when monitoring keyboard activity
#  # -t   == Do not disable mouse movement when typing. Only disable tapping.
#  syndaemon -t -k -i 2 &
#fi
if type synclient 2>/dev/null; then
  # Attempt to detect palm placement. I did have this in xorg.init.d/
  # 50-synaptics.  but X failed to parse it after a system upgrade.
  synclient PalmDetect=1
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# exec xterm

IS_ARCH=0
if (uname -r | grep "ARCH") 1>/dev/null; then
  IS_ARCH=true
else
  IS_ARCH=false
fi

if [ "$IS_ARCH" = true ]; then
  # We shouldn't be using xmodmap anymore. We should use the xkb
  # X11 extension to process keyboard inputs.
  # Note: Information regarding available options can be found
  #       in a file named base.lst (/usr/share/X11/xkb/rules)
  # See: https://wiki.archlinux.org/index.php/X_KeyBoard_extension
  setxkbmap dvorak -option 'caps:swapescape,ctrl:swap_rwin_rctl'
fi

if [ -s ~/.Xmodmap ]; then
  if type xmodmap 2>/dev/null; then
    xmodmap ~/.Xmodmap
  else
    echo "xinitrc: Unable to find xmodmap (pacman xorg-xmodmap package)"
  fi
fi

if [ -s ~/.xbindkeys ]; then
  if type xbindkeys 2>/dev/null; then
    xbindkeys
  else
    echo "xinitrc: Unable to find xbindkeys (pacman xbindkeys package)"
  fi
fi

if [ "$IS_ARCH" = true ]; then
  # Start the GPG agent if it hasn't been started already.
  if type gpg-agent >/dev/null 2>&1; then
    gnupginf="$HOME/.gnupg/gpg-agent.info"
    if pgrep -x -u "${USER}" gpg-agent > /dev/null 2>&1; then
      # I don't think we need this section. gnupginf no longer gets written out.
      eval `cat $gnupginf`
      eval `cut -d= -f1 $gnupginf | xargs echo export`
    else
      eval `gpg-agent -s --daemon --enable-ssh-support --write-env-file "$gnupginf"`
    fi
  fi
fi

# Ctrl-t and up / down / right / left equivalents are set up in
# the window manager.
exec i3
#exec xterm
