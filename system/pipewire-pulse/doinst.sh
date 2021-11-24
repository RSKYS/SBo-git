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

removepkg pulseaudio-pipe > /dev/null

( cd /etc/pulse
if [ -f "client.conf" ] && [ ! -f ".client.conf.old" ]; then
    mv client.conf .client.conf.old
fi )

( cd /etc/xdg/autostart
if [ -f "pulseaudio.desktop" ]; then
    rm -f .pulseaudio.desktop.old
    mv pulseaudio.desktop .pulseaudio.desktop.old
fi )

config etc/xdg/autostart/pipewire-media-session.desktop.new
config etc/xdg/autostart/pipewire-pulse.desktop.new
config etc/xdg/autostart/pipewire.desktop.new
config etc/pulse/client.conf.new
