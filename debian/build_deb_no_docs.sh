#!/bin/bash
# script to make main_package, main_package-dev debs but
# without making docs packages

this=${0##*/}
this_dir="${0%/*}"
cd "$this_dir"

case $# in
  1) ;;
  *) cat <<EOF

$this: No parameters specified
Usage:
      $this parameters_for_configure_script

EOF
exit 1
     ;;
esac

BUILD_DOCS=0 ./configure $* # make deb with no doc packages
(cd ..;  time debuild -i -us -uc -b \
         && ls -lrt ../*.{deb,build,changes} 2>/dev/null)

# dpkg-buildpackage args
#  -i
#  -uc  Do not sign the .changes
#  -us  Do not sign the source package
#  -b   Specifies a binary-only build

exit 0
