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

( cd /etc/sboui
if [ -f sboui.conf ]; then
    md5check="$(md5sum sboui.conf | cut -d' ' -f1)"
    if [ $md5check != "d653dfd49b145f660b585139140dc393" ]; then
        rm -f .sboui.conf.old
        mv sboui.conf .sboui.conf.old
    fi
fi

if [ -f sboui-backend.conf ]; then
    md5check="$(md5sum sboui-backend.conf | cut -d' ' -f1)"
    if [ $md5check != "f25e40b1488c57e31d0da7b21cea3ec5" ]; then
        rm -f .sboui-backend.conf.old
        mv sboui-backend.conf .sboui-backend.conf.old
    fi
fi )

config etc/sboui/sboui.conf.new
config etc/sboui/sboui-backend.conf.new
config etc/sboui/package_blacklist.new

if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache -f usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
