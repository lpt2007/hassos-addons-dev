mkdir -p /share/volumes/smb/kodi_18_smb/data >/dev/null 2>&1 || true && rm -rf /root/.kodi && ln -s /share/volumes/smb/kodi_18_smb/data /root/.kodi \
&& mkdir -p /data >/dev/null 2>&1

#export SDL_MOUSE_RELATIVE=0

/usr/bin/kodi
