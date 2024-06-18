config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/xdg/lxsession/LXDE/desktop.conf.new
config etc/xdg/lxsession/LXDE/autostart.new
config etc/xdg/pcmanfm/LXDE/pcmanfm.conf.new
config etc/xdg/lxpanel/LXDE/panels/panel.new
config etc/xdg/lxpanel/LXDE/config.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi
