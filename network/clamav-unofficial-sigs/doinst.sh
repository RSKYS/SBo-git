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

config etc/clamav-unofficial-sigs/master.conf.new
config etc/clamav-unofficial-sigs/user.conf.new
config etc/clamav-unofficial-sigs/os.conf.new
config etc/logrotate.d/clamav-unofficial-sigs.new
printf "Please review UPGRADE_NOTICE in the docs\n"
