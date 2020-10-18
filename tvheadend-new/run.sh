#!/bin/bash
set -e

OPTIONS_PATH=/data/options.json

echo "[INFO] setup vlan"
vlan_id=$(jq -r '.vlan_id' $OPTIONS_PATH)
vlan_ip=$(jq -r '.vlan_ip' $OPTIONS_PATH)
vlan_nm=$(jq -r '.vlan_nm' $OPTIONS_PATH)
route_ip=$(jq -r '.route_ip' $OPTIONS_PATH)
route_nm=$(jq -r '.route_nm' $OPTIONS_PATH)
gateway=$(jq -r '.gateway' $OPTIONS_PATH)
ethernet=$(jq -r '.ethernet' $OPTIONS_PATH)

vconfig add eth0 3999
ifconfig $ethernet.$vlan_id $vlan_ip netmask $vlan_nm up
route add -net $route_ip netmask $route_nm dev $ethernet.$vlan_id
sysctl -w net.ipv4.conf.$ethernet.$vlan_id.rp_filter=0
sysctl -w net.ipv4.conf.all.rp_filter=0
(
usleep 65000000
route add default gw $gateway $ethernet
)&

#mkdir -p /share/tvheadend/recordings
#mkdir -p ~/.wg++
#ln -sf /share/tvheadend/wg++/guide.xml ~/.wg++/guide.xml

#Install WebGrabPlus
#if  [ "$(ls -A /share/tvheadend/wg++)" ]; then
#    echo "[INFO] Webgrab+ already installed"
#else
#    echo "[INFO] No webgrab+ installation found - Installing webgrab+"
#    cd /tmp  && \
#    wget http://www.webgrabplus.com/sites/default/files/download/SW/V2.1.0/WebGrabPlus_V2.1_install.tar.gz  && \
#    tar -xvf WebGrabPlus_V2.1_install.tar.gz && rm WebGrabPlus_V2.1_install.tar.gz  && \
#    mv .wg++/ /share/tvheadend/wg++  && \
#    cd /share/tvheadend/wg++  && \
#    ./install.sh
#
#    rm -rf siteini.pack/  && \
#    git clone https://github.com/DeBaschdi/webgrabplus-siteinipack.git  && \
#    cp -R webgrabplus-siteinipack/siteini.pack/ siteini.pack  && \
#    cp siteini.pack/International/horizon.tv.* siteini.user/
#fi

#wget -O /usr/bin/tv_grab_wg++ http://www.webgrabplus.com/sites/default/files/tv_grab_wg.txt  && \
#chmod a+x /usr/bin/tv_grab_wg++

#echo "0 0 * * * /share/tvheadend/wg++/run.sh" >> /var/spool/cron/root
#crond

echo "[INFO] Starting TVHeadend"
/usr/bin/tvheadend --firstrun -u root -g root -c /share/tvheadend

