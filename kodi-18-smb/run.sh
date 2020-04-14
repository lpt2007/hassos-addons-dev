#!/bin/bash
set -e

OPTIONS_PATH=/data/options.json
##
#make directory structure in not exist - locale
mkdir -p /share/its
mkdir -p /share/its/smb_data
mkdir -p /share/its/loc_data
##
##
#add samba user and password to /ssl/kodi_smb.txt
smb_user=$(jq -r '.smb_user' $OPTIONS_PATH)
smb_pass=$(jq -r '.smb_pass' $OPTIONS_PATH)
ssl=/ssl/kodi_smb.txt
ssl_cmp=/ssl/kodi_smb.cmp
if [ "$smb_user" == "" ]; then
            echo "[ERROR] Samba username not configured"
            echo "[ERROR] Check addon configuration!"
        else
         if [ "$smb_pass" == "" ]; then
            echo "[ERROR] Samba password not configured"
            echo "[ERROR] Check addon configuration!"
        else
            echo "[INFO] Fond Samba Server username $smb_user"
            echo "[INFO] Fond Samba Server password"
          if test -f "$ssl"; then
            echo "[INFO] Found file $ssl"
            echo 'username='$smb_user >> $ssl_cmp
            echo 'password='$smb_pass >> $ssl_cmp
            if ! cmp $ssl $ssl_cmp > /dev/null 2>&1; then
              echo "[INFO] File $ssl changed."
              echo "[INFO] Deleting file $ssl."
              rm $ssl
              echo "[INFO] Creating new file $ssl."
              echo 'username='$smb_user >> $ssl
              echo 'password='$smb_pass >> $ssl
            else
              echo "[INFO] File $ssl not changed"
              rm $ssl_cmp
            fi         
          else
            echo "[INFO] File $ssl not found."
            echo "[INFO] Creating File $ssl."
            echo 'username='$smb_user >> $ssl
            echo 'password='$smb_pass >> $ssl
          fi
         fi
fi
##
#add samba share
smb_ip=$(jq -r '.smb_ip' $OPTIONS_PATH)
smb_path=$(jq -r '.smb_path' $OPTIONS_PATH)
if [ "$smb_ip" == "" ]; then
            echo "[ERROR] Samba IP not configured"
            echo "[ERROR] Check addon configuration!"
        else
         if [ "$smb_path" == "" ]; then
            echo "[ERROR] Samba path not configured"
            echo "[ERROR] Check addon configuration!"
        else
            echo "[INFO] Fond Samba Server IP $smb_ip"
            echo "[INFO] Fond Samba path $smb_path"
            echo '//'$smb_ip'/'$smb_path' /share/its/smb_data cifs rw,credentials=/ssl/kodi_smb.txt,uid=0,gid=0,file_mode=0660,dir_mode=0770,vers=1.0 0 0' >> /etc/fstab
            mount -a
         fi
fi
##
#make directory structure in not exist - smb
kodi_data=$(jq -r '.kodi_data' $OPTIONS_PATH)
if [ "$kodi_data" == "" ]; then
            echo "[ERROR] No kodi folder configured"
            echo "[ERROR] Check addon configuration!"
        else
            echo "[INFO] Fond kodi folder $kodi_data"
            mkdir -p /share/its/smb_data/$kodi_data
            echo "[INFO] remove .kodi before making symbolic link."
            rm -r -f /root/.kodi
            echo "[INFO] Making symbolic link to /share/its/smb_data/$kodi_data."
            ln -s /share/its/smb_data/$kodi_data /root/.kodi
fi
##
#make sqllit database folder symbolic link
smb_database=/share/its/smb_data/$kodi_data/userdata/Database
loc_database=/share/its/loc_data/$kodi_data/userdata/Database
if [ -d "$smb_database" ]; then
            echo "[INFO] Sqlite database found on samba share"
            echo "[INFO] Create $loc_database folder"
            rm -r -f /share/its/loc_data
            mkdir -p /share/its/loc_data/$kodi_data
            mkdir -p /share/its/loc_data/$kodi_data/userdata
            mkdir -p /share/its/loc_data/$kodi_data/userdata/Database
if [[ -L "$smb_database" && -d "$smb_database" ]]
then
    echo "[INFO] Database is a symlink to a directory skip moveing files"
else
    echo "[INFO] Remove all files from $loc_database."
    rm -r -f /share/its/loc_data/$kodi_data
    echo "[INFO] Create $loc_database."
    mkdir -p /share/its/loc_data/$kodi_data
    mkdir -p /share/its/loc_data/$kodi_data/userdata
    mkdir -p /share/its/loc_data/$kodi_data/userdata/Database
    echo "[INFO] Move files from $smb_database."
    mv $smb_database* $loc_database
    echo "[INFO] Remove database folder on samba share"
    rm -r -f $smb_database
    echo "[INFO] Making symbolic link to $smb_database."
    ln -s $loc_database $smb_database
fi
        else            
            echo "[INFO] No sqllite database found on samba share."
            echo "[INFO] Create $smb_database."
            mkdir -p /share/its/smb_data/$kodi_data/userdata
            echo "[INFO] Create $loc_database."
            rm -r -f /share/its/loc_data
            mkdir -p /share/its/loc_data/$kodi_data
            mkdir -p /share/its/loc_data/$kodi_data/userdata
            mkdir -p /share/its/loc_data/$kodi_data/userdata/Database
            echo "[INFO] Making symbolic link to $smb_database."
            ln -s  $loc_database $smb_database
fi
##
#run kodi
echo "[INFO] Started KODI media center"
/usr/bin/kodi
