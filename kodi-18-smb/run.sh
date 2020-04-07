mkdir -p /share/kodi-gui-new/data >/dev/null 2>&1 || true && rm -rf /root/.kodi && ln -s /share/kodi-gui-new/data /root/.kodi \
&& mkdir -p /data >/dev/null 2>&1

#export SDL_MOUSE_RELATIVE=0

/usr/bin/kodi
