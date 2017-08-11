#! /bin/sh

# Write a list of packages currently installed or read that list,
# presumably after a firmware upgrade, in order to reinstall all packages
# on that list not currently installed
#
# (c) 2013 Malte Forkel <malte.forkel@berlin.de>
#
# Version history
#    0.1.0 - Initial release

PCKGLIST=/etc/config/opkg.installed  # default package list
INSTLIST=$(mktemp)                   # list of packages to install
PREQLIST=$(mktemp)                   # list of prerequisite packages

WRITE=false                          # write a package list
UPDATE=false                         # update the package database
ACTOPT=""                            # test only, no action
VERBOSE=false                        # be verbose

cleanup () {
    rm -f $INSTLIST $PREQLIST
}

echo_usage () {
    echo \
"Usage: $(basename $0) [options] [packagelist]

The default package list is $PCKGLIST.

Options:
  -h     print this help message
  -t     test only, execute opkg commands with --noaction
  -u     update the package database
  -v     be verbose
  -w     write the list of currently installed packages"
}

trap cleanup SIGHUP SIGINT SIGTERM EXIT

# parse command line options
while getopts "htuvw" OPTS; do
    case $OPTS in
        t )
            ACTOPT="--noaction";;
        u )
            UPDATE=true;;
        v )
            VERBOSE=true;;
        w )
            WRITE=true;;
        [h\?*] )
            echo_usage
            exit 0;;
    esac
done
shift $(($OPTIND - 1))

# Set name of the package list
if [ "x$1" != "x" ]; then
    PCKGLIST="$1"
fi

#
# Write
#

if $WRITE; then
    if $VERBOSE; then
        echo "Saving package list to $PCKGLIST"
    fi
    # NOTE: option --noaction not valid for list-installed
    opkg list-installed > "$PCKGLIST"
    exit 0
fi

#
# Update 
#

if $UPDATE; then
    opkg $ACTOPT update
fi

#
# Install
#

# detect uninstalled packages
if $VERBOSE; then
    echo "Checking packages... "
fi
cat "$PCKGLIST" | while read PACKAGE SEP VERSION; do
    # opkg status is much faster than opkg info
    # it only returns status of installed packages
    #if ! opkg status $PACKAGE | grep -q "^Status:.* installed"; then
    if [ "x$(opkg status $PACKAGE)" == "x" ]; then
        # collect uninstalled packages
        echo $PACKAGE >> $INSTLIST
        # collect prerequisites
        opkg info "$PACKAGE" |
        awk "/^Depends: / {
                            sub(\"Depends: \", \"\");   \
                            gsub(\", \", \"\\n\");      \
                            print >> \"$PREQLIST\";      \
                          }"
    fi
done

# install packages
cat "$INSTLIST" | while read PACKAGE; do
    if grep -q "^$PACKAGE\$" "$PREQLIST"; then
        # prerequisite package, will be installed automatically
        if $VERBOSE; then
            echo "$PACKAGE installed automatically"
        fi
    else
        # install package
        opkg $ACTOPT install $PACKAGE
    fi
done

# clean up and exit
exit 0

