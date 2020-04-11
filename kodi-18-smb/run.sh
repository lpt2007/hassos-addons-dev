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
smb_ip=$(jq -r '.smb_ip' $OPTIONS_PATH)
smb_path=$(jq -r '.smb_path' $OPTIONS_PATH)
if [ "$smb_ip" == "" ]; then
            echo "[INFO] Samba IP not configured"
        else
         if [ "$smb_path" == "" ]; then
            echo "[INFO] Samba path not configured"
        else
            echo "[INFO] Fond Samba Server IP $smb_ip"
            echo "[INFO] Fond Samba path $smb_path"
            echo '//$smb_ip/$smb_path /share/its/smb_data cifs rw,credentials=/ssl/kodi_smb.txt,uid=0,gid=0,file_mode=0660,dir_mode=0770,vers=1.0 0 0' >> /etc/fstab
            mount -a
         fi
fi
##
#make directory structure in not exist - smb
kodi_data=$(jq -r '.kodi_data' $OPTIONS_PATH)
if [ "$kodi_data" == "" ]; then
            echo "[INFO] No kodi folder configured"
        else
            echo "[INFO] Fond kodi folder $kodi_data"
            mkdir -p /share/its/smb_data/$kodi_data
            ##
            #make simbolic link to smb folder
            echo "[INFO] Making symbolic link from /root/.kodi to /share/its/smb_data/$kodi_data"
            ln -s /share/its/smb_data/$kodi_data /root/.kodi
fi
##
#run kodi
/usr/bin/kodi
