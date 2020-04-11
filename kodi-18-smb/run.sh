#!/bin/bash
set -e

OPTIONS_PATH=/data/options.json
##
#make directory structure in not exist - locale
mkdir -p /share/its
mkdir -p /share/its/smb_data
mkdir -p /share/its/cfg
##
#add samba share
echo '//192.168.0.198/smb$/data /share/its/smb_data cifs rw,credentials=/share/its/cfg/ssh_addon_smb.txt,uid=0,gid=0,file_mode=0660,dir_mode=0770,vers=1.0 0 0' >> /etc/fstab
mount -a
##
#make directory structure in not exist - smb
jq -r '.kodi_data' $OPTIONS_PATH
while read kodi_data; do
if [ "$kodi_data" == "" ]; then
            echo "[INFO] No kodi folder configured"
        else
            echo "[INFO] Fond kodi folder $kodi_data"
            mkdir -p /share/its/smb_data/$kodi_data
##
#make simbolic link to smb folder
ln -s /share/its/smb_data/$kodi_data /root/.kodi
done
##
#mkdir -p /share/its/smb_data/kodi_18_smb/data >/dev/null 2>&1 || true && rm -rf /root/.kodi && ln -s /share/its/smb_data/kodi_18_smb/data /root/.kodi \
#&& mkdir -p /data >/dev/null 2>&1

/usr/bin/kodi
