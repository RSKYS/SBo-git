#!/bin/bash
# This script meant to identify what script is in dependencies but
# it's removed from slackbuilds and does not exist anymore, we don't
# like sboui warnings, do we?

cwd=$(echo $(pwd)/..)
cd $cwd

list=$(cat */*/*.info | grep 'REQUIRES=' | \
                        sed -e 's/"//g' \
                            -e 's/REQUIRES=//g' \
                            -e 's/ /\'$'\n''/g' | sort -u)

for item in $list; do
    ( cd $cwd
      cd */$item )
done