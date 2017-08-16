#!/bin/sh

SPATH=/root/ent-dh-fw/scripts
ROOTCRON=/etc/crontabs/root
FILEN='fw-update.sh'

if ! grep -q "$FILEN" $ROOTCRON > /dev/null
then 
  echo "0 22 * * * $SPATH/$FILEN" >> $ROOTCRON
  /etc/init.d/cron enable
  /etc/init.d/cron start
fi

opkg update > /dev/null 2>&1
PKGS=`opkg list-installed | awk '{print $1}' | sed ':M;N;$!bM;s#\n# #g'`
for i in $PKGS
do
   # echo Checking and upgrading package $i as required. 
   opkg upgrade $i > /dev/null 2>&1 ; 
done;

