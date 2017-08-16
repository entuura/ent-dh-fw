#!/bin/sh

#opkg update > /dev/null 2>&1 ; opkg list-upgradable|grep -v Multiple|cut -d ' ' -f 1|xargs opkg upgrade > /dev/null  2>&1

opkg update > /dev/null 2>&1

PKGS=`opkg list-installed | awk '{print $1}' | sed ':M;N;$!bM;s#\n# #g'`

for i in $PKGS
do
   # echo Checking and upgrading package $i as required. 
   opkg upgrade $i > /dev/null 2>&1 ; 
done;

