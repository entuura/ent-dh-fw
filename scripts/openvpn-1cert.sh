#!/bin/sh
ENTFILESPATH=/root/ent-dh-fw/files
CNAME="dh-vpnserver"
cp -f $ENTFILESPATH/vars /etc/easy-rsa/
cd /etc/easy-rsa

source vars
clean-all
(echo -en "\n\n\n\n\n\n\n\n") | build-ca
(echo -en "\n\n\n\n\n\n\n\n";echo -en "\n"; echo -en "\n"; sleep 3; echo -en "y\n"; sleep 2; echo -en "y\n") | build-key-server $CNAME
openvpn --genkey --secret /etc/easy-rsa/keys/ta.key

#Doing it this way to save some time on the 2nd time you set up a vpn.
if [ ! -f /etc/easy-rsa/dh4096.pem ]; then
    build-dh
    cp /etc/easy-rsa/keys/dh4096.pem /etc/easy-rsa/dh4096.pem
else 
    cp /etc/easy-rsa/dh4096.pem /etc/easy-rsa/keys/dh4096.pem
fi

