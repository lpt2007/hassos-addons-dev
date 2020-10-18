usleep 1000000
vconfig add eth0 3999
ifconfig eth0.3999 10.32.10.32 netmask 255.255.0.0 up
route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0.3999
sysctl -w net.ipv4.conf.eth0.3999.rp_filter=0
sysctl -w net.ipv4.conf.all.rp_filter=0
(
usleep 65000000
route add default gw 192.168.178.1 eth0
)&
