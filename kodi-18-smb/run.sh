#!/bin/bash
set -e

OPTIONS_PATH=/data/options.json
#
#read if samab use true or false
smb=$(jq -r '.smb' $OPTIONS_PATH)
##
#check smb true/false
#true - proceed to samba configuration
if [ "$smb" == "true" ]; then
echo "[INFO] SAMBA IS ENABLED"
##
echo "[INFO] Start KODI with SMB prestart"
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
            echo "[INFO] Samba username not configured"
        else
         if [ "$smb_pass" == "" ]; then
            echo "[INFO] Samba password not configured"
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
#add samba share to fstab
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
            echo '//'$smb_ip'/'$smb_path' /share/its/smb_data cifs rw,credentials=/ssl/kodi_smb.txt,uid=0,gid=0,file_mode=0660,dir_mode=0770,vers=1.0 0 0' >> /etc/fstab
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
#make sqllit database folder symbolic link
if [ -d "/share/its/smb_data/$kodi_data/userdata/Database" ]; then
            echo "[INFO] Sqlite database found on samba share"
            echo "[INFO] Create /share/its/loc_data/$kodi_data folder if not exist"
            mkdir -p /share/its/loc_data/$kodi_data
if [[ -L "/share/its/smb_data/$kodi_data/userdata/Database" && -d "/share/its/smb_data/$kodi_data/userdata/Database" ]]
then
    echo "[INFO] Database is a symlink to a directory skip moveing files"
else
    echo "[INFO] Remove all files from local database directory."
    rm -r /share/its/loc_data/$kodi_data/
    echo "[INFO] Create /share/its/loc_data/$kodi_data folder if not exist"
    mkdir -p /share/its/loc_data/$kodi_data
    echo "[INFO] Move files from /share/its/smb_data/$kodi_data/userdata/Database"
    mv /share/its/smb_data/$kodi_data/userdata/Database/* /share/its/loc_data/$kodi_data
    echo "[INFO] Remove database folder on samba share"
    rm -r  /share/its/smb_data/$kodi_data/userdata/Database/
    echo "[INFO] Making symbolic link to /share/its/smb_data/$kodi_data/userdata/Database"
    ln -s /share/its/loc_data/$kodi_data /share/its/smb_data/$kodi_data/userdata/Database
fi
        else            
            echo "[INFO] No sqllite database found on samba share."
            echo "[INFO] Create /share/its/smb_data/$kodi_data/userdata/Database folder if not exist"
            mkdir -p /share/its/smb_data/$kodi_data/userdata
            echo "[INFO] Create /share/its/loc_data/$kodi_data folder if not exist"
            mkdir -p /share/its/loc_data/$kodi_data
            echo "[INFO] Making symbolic link to /share/its/smb_data/$kodi_data/userdata/Database"
            ln -s  /share/its/loc_data/$kodi_data /share/its/smb_data/$kodi_data/userdata/Database
fi
##
else
echo "[INFO] SAMBA IS DISABLED"
echo "[INFO] Start KODI prestart"
##
#make directory structure in not exist
mkdir -p /share/its
mkdir -p /share/its/data
##
kodi_data=$(jq -r '.kodi_data' $OPTIONS_PATH)
if [ "$kodi_data" == "" ]; then
            echo "[INFO] No kodi folder configured"
       else
            echo "[INFO] Fond kodi folder $kodi_data"
            mkdir -p /share/its/data/$kodi_data
            #make simbolic link to data folder
            echo "[INFO] Making symbolic link from /root/.kodi to /share/its/data/$kodi_data"
            ln -s /share/its/data/$kodi_data /root/.kodi
fi

fi
##
#run kodi
echo "[INFO] Started KODI media center"
usermod -a -G audio,video,input,dialout,plugdev,users,cdrom,tty "root"
/usr/bin/kodi
