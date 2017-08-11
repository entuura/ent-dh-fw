#!/bin/sh

opkg update && opkg install openvpn-openssl openvpn-easy-rsa luci-app-openvpn

PORT=22
TYPE='udp'

uci set network.vpn0="interface"
uci set network.vpn0.ifname="tun0"
uci set network.vpn0.proto="none"
uci set network.vpn0.auto="1"
uci commit network
uci add firewall rule
uci set firewall.@rule[-1].name="Allow-OpenVPN-Inbound"
uci set firewall.@rule[-1].target="ACCEPT"
uci set firewall.@rule[-1].src="wan"
uci set firewall.@rule[-1].proto="$TYPE"
uci set firewall.@rule[-1].dest_port="$PORT"
uci add firewall zone
uci set firewall.@zone[-1].name="vpn"
uci set firewall.@zone[-1].input="ACCEPT"
uci set firewall.@zone[-1].forward="ACCEPT"
uci set firewall.@zone[-1].output="ACCEPT"
uci set firewall.@zone[-1].masq="1"
uci set firewall.@zone[-1].network="vpn0"
uci add firewall forwarding
uci set firewall.@forwarding[-1].src="vpn"
uci set firewall.@forwarding[-1].dest="wan"
uci add firewall forwarding
uci set firewall.@forwarding[-1].src="vpn"
uci set firewall.@forwarding[-1].dest="lan"
uci commit firewall

/etc/init.d/network reload
/etc/init.d/firewall reload

