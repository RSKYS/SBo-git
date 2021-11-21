#!/bin/sh
config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

removepkg pipewire-pulse > /dev/null

( cd /etc/pulse
  rm -f client.conf .client.conf.old
)

( cd /etc/xdg/autostart
  rm -f pipewire*.desktop .pipewire*.old .pulseaudio*.desktop
)

config etc/pulse/client.conf.newl
