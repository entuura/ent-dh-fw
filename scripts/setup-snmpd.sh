#!/bin/sh
# Entuura Ventures Limited
# Steven Uggowitzer steven@entuura.organization

#-----------------------------------------------------------------------------
# SNMP Setup
opkg install mini_snmpd
uci set mini_snmpd.@mini_snmpd[0].community='WildeepGVARO'
uci set mini_snmpd.@mini_snmpd[0].location='Bassins, Switzerland'
uci set mini_snmpd.@mini_snmpd[0].contact='Steven Uggowitzer <whotopia@gmail.com>'
uci delete mini_snmpd.@mini_snmpd[0].interfaces
uci add_list mini_snmpd.@mini_snmpd[0].interfaces=lan
uci add_list mini_snmpd.@mini_snmpd[0].interfaces=wan
uci add_list mini_snmpd.@mini_snmpd[0].interfaces=loopback
uci delete mini_snmpd.@mini_snmpd[0].disks
uci add_list mini_snmpd.@mini_snmpd[0].disks='/tmp'

uci commit mini_snmpd
/etc/init.d/mini_snmpd enable
/etc/init.d/mini_snmpd stop > /dev/null 2>&1
/etc/init.d/mini_snmpd start
#-----------------------------------------------------------------------------
