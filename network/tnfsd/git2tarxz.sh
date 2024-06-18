#!/bin/sh

# Create source tarball from git repo, with generated version number.

# This is not a generic git2tarxz script, it's specific to tnfsd.
# Upstream doesn't use tags for version bumps, so the version number
# is extracted from main.c. Also, the repo contains a bunch of
# other stuff unrelated to tnfs, which we don't include in our
# tarball.

# Takes one optional argument, which is the commit or tag to create a
# tarball of. With no arg, HEAD is used.

# Version number example: 0.0.1+20200227_ad7ec17

# Notes:

# Do not use this if you're packaging a release.

# This script doesn't need to be run as root. It does need to be able
# to write to the current directory it's run from.

# Running this script twice for the same commit will NOT give identical
# tarballs, even if the contents are identical. This is because tar
# includes the current time in a newly-created tarball (plus there may
# be other git-related reasons).

# Once you've generated a tarball, you'll still need a place to host it.
# Ask on the mailing list, if you don't have your own web server to
# play with.

## Config:
PRGNAM=tnfsd
CLONE_URL=https://github.com/FujiNetWIFI/spectranet/
## End of config.

set -e

GITDIR=$( mktemp -dt $PRGNAM.git.XXXXXX )
rm -rf $GITDIR
git clone $CLONE_URL $GITDIR

CWD="$( pwd )"
cd $GITDIR

if [ "$1" != "" ]; then
  git reset --hard "$1" || exit 1
fi

GIT_SHA=$( git rev-parse --short HEAD )

# the version hardcoded in main.c includes the date, so
# don't use this.
#DATE=$( git log --date=format:%Y%m%d --format=%cd | head -1 )
#VERSION=${DATE}_${GIT_SHA}

VERMAIN="$( grep 'const  *char  *\*version' tnfs/tnfsd/main.c | cut -d'"' -f2 )"
VERSION=${VERMAIN}_${GIT_SHA}

rm -rf .git
find . -name .gitignore -print0 | xargs -0 rm -f

rm -rf tnfs/tnfsd/{vscode_sample,bin/*}
mv tnfs/*.{md,txt} tnfs/tnfsd

cd "$CWD"
rm -rf $PRGNAM-$VERSION $PRGNAM-$VERSION.tar.xz
mv $GITDIR/tnfs/tnfsd $PRGNAM-$VERSION
rm -rf $GITDIR
tar cvfJ $PRGNAM-$VERSION.tar.xz $PRGNAM-$VERSION

echo
echo "Created tarball: $PRGNAM-$VERSION.tar.xz"
echo "VERSION=\"$VERSION\""
echo "MD5SUM=\"$( md5sum $PRGNAM-$VERSION.tar.xz | cut -d' ' -f1 )\""
