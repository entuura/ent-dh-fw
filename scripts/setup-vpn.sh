opkg install strongswan-full strongswan-default strongswan-mod-kernel-libipsec iptables-mod-filter iptables-mod-nat-extra

#STRONGSWAN
cd /etc/ipsec.d/
ipsec pki --gen --type rsa --size 4096 --outform pem \
    > private/strongswan-key.pem

chmod 600 private/strongswan-key.pem

ipsec pki --self --ca \
    --lifetime 3650 \
    --in private/strongswan-key.pem \
    --type rsa \
    --dn "C=CH, ST=Vaud, L=Bassins, O=Entuura, CN=Entuura Sovereign Site CA" \
    --outform pem \
    > cacerts/strongswan-certificate.pem

#To verify the certificate

ipsec pki --print --in cacerts/strongswan-certificate.pem

#To generate the VPN Host Certificate

cd /etc/ipsec.d/

ipsec pki --gen --type rsa --size 4096 --outform pem \
        > private/vpn-host-key.pem

chmod 600 private/vpn-host-key.pem

ipsec pki --pub --in private/vpn-host-key.pem --type rsa | \
  ipsec pki --issue --lifetime 1825 \
  --cacert cacerts/strongswan-certificate.pem \
  --cakey private/strongswan-key.pem \
  --dn "C=CH, ST=Vaud, L=Bassins, O=Entuura, CN=vpn.entuura.info" \
  --san "vpn.entuura.info" \
  --flag serverAuth --flag ikeIntermediate \
  --outform pem > certs/vpn-host-certificate.pem

#To generate the Client Certificate
  cd /etc/ipsec.d/

  ipsec pki --gen --type rsa --size 2048 --outform pem \
      > private/dev-key.pem

  chmod 600 private/dev-key.pem

  ipsec pki --pub --in private/dev-key.pem --type rsa | \
    ipsec pki --issue --lifetime 1825 \
      --cacert cacerts/strongswan-certificate.pem \
      --cakey private/strongswan-key.pem \
      --dn "C=CH, ST=Vaud, L=Bassins, O=Entuura, CN=dev@entuura.org" \
      --san "dev@entuura.org" \
      --outform pem > certs/dev-certificate.pem

#To verify the client certificate
ipsec pki --print --in certs/dev-certificate.pem

#To export the Client Certificate
cd /etc/ipsec.d/

openssl pkcs12 -export -inkey private/dev-key.pem \
    -in certs/dev-certificate.pem \
    -name "Entuura Dev Helpdesk VPN Certificate" \
    -certfile cacerts/strongswan-certificate.pem \
    -caname "Entuura Root CA" \
    -out certs/dev.p12
