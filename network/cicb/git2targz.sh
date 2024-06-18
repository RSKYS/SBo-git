#!/bin/sh

# Create source tarball from cicb git repo, with generated version
# number. We don't include the git history in the tarball.
# We also don't include the linenoise-1.0/ dir, since it's a readline
# replacement for OSes that don't have readline... and Slackware
# isn't one of those OSes.

# Note that this script doesn't need to be run as root. It does
# need to be able to write to the current directory it's run from.

PRGNAM=cicb
CLONE_URL=https://github.com/hoche/$PRGNAM.git

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

# Extract date from last entry in git log. git has so many useful
# options that it's a PITA to find the one you need...
DATE=$( git log --date=format:%Y%m%d --pretty=format:%cd -n1 )

VERFILE=icb/version.h
WHATVER=$( sed -n 's,#define *WHAT_VERSION.*Version \([^"]*\)",\1,p' $VERFILE | sed 's,-,,' )

VERSION=${WHATVER}+git$DATE

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f
rm -rf linenoise-*/

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR $PRGNAM-$VERSION
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

cat <<EOF

Archive created: $PRGNAM-$VERSION.tar.xz

Update $PRGNAM.info with:

VERSION="$VERSION"
DOWNLOAD="https://slackware.uk/~urchlay/src/$PRGNAM-$VERSION.tar.xz"
MD5SUM="$( md5sum $PRGNAM-$VERSION.tar.xz | cut -d' ' -f1 )"

Don't forget to upload the new source!
EOF
