if [ -x /usr/bin/mkfontdir ]; then
  ( cd usr/share/fonts/misc
    grep -v '^Dina_\([689]\|10\) ' fonts.alias > fonts.alias.new
    mv fonts.alias.new fonts.alias
    mkfontscale .
    mkfontdir .
  )
fi

[ "$DISPLAY" != "" ] && xset fp rehash 2>/dev/null

if [ -x usr/bin/fc-cache ]; then
  usr/bin/fc-cache -f
fi
