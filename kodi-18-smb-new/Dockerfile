ARG BUILD_FROM=homeassistant/base
FROM ${BUILD_FROM}

RUN echo "[INFO] Installing KODI"
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN apk update && apk upgrade && apk add --update kodi && rm -rf /var/cache/apk/*

RUN echo "[INFO] Installing SAMBA"
RUN apk add cifs-utils

RUN apk add mesa-dri-vc4 mesa-egl xf86-video-fbdev xf86-video-vesa xf86-input-mouse xf86-input-keyboard dbus setxkbmap kbd xrandr xset xinit xterm xorg-server

RUN echo "[INFO] Starting KODI"
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]

# Labels
LABEL \
    io.hass.name="kodi-18-smb-new" \
    io.hass.description="Media Player Add-On" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/lpt2007" \
    org.label-schema.description="TVHeadend Add-On" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="kodi-18-smb-new" \
    org.label-schema.schema-version="0.12a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-new" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-new" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-new" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-new"
