#!/bin/sh
ENTFILESPATH=/root/ent-dh-fw/files
ENTSCRIPTSPATH=/root/ent-dh-fw/scripts
CURPATH=`pwd`
cd /etc/easy-rsa
source vars

CRT=".crt"
NAME="${1}"
PASSWD="${2}"
PATHH="/etc/easy-rsa/keys"

if [ -z "${NAME}" ]; then
  # Ask for a Client name
  echo "Please enter a unique VPN client name:"
  read NAME
fi

if [ -z "${PASSWD}" ]; then
  # Ask for a Client Password 
   echo "Please enter a VPN client password:"
  read PASSWD
fi

#1st Verify that client's Public Key Exists
if [ -f "$PATHH/$NAME$CRT" ]; then
  echo "[ERROR]: Client Public Key Certificate already exists: $NAME$CRT"
  exit
fi
echo "Client's cert now being created: $NAME$CR"

export EASY_RSA="${EASY_RSA:-.}"
#(sleep 1; echo -en "\n\n";sleep 1; echo -en "\n\n" ) | "/usr/sbin/pkitool" --batch --pkcs12 $NAME
echo "In the next step, please press ENTER twice for the Export Password"
yes '' | "/usr/sbin/pkitool" --batch --pkcs12 $NAME

openssl rsa -in $PATHH/$NAME.key -des3 -out $PATHH/$NAME.3des.key -passout pass:$PASSWD

if [ ! -f "$PATHH/Default.txt" ]; then
   echo "Copying Default.txt template...."
   cp $ENTFILESPATH/Default.txt $PATHH
fi

echo "Now building OVPN file"
source $ENTSCRIPTSPATH/MakeOpenVPN.sh $NAME
cd $CURPATH
echo "OVPN file created at: $PATHH/$NAME.ovpn"

