#!/bin/sh

ENTFILESPATH=/root/ent-dh-fw/files
cp -f $ENTFILESPATH/openvpn /etc/config/

#in future have some config custimisations templating

rm -f /tmp/etc/openvpn-DigitalHealth_DHIS2_VPN.conf

/etc/init.d/openvpn stop
/etc/init.d/openvpn start
/etc/init.d/openvpn enable

