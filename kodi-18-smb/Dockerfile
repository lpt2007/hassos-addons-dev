FROM b01t/raspbian

### install minimal dependencies
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends xserver-xorg xinit \
     fbset \
     libraspberrypi0 \
     cifs-utils \
     xserver-xorg-legacy \
     dbus-x11 \
     jq \
     nano \
     kodi

### Copy data for add-on and make right privilages
COPY run.sh /
RUN chmod a+x /run.sh
##
### run kodi startup script
CMD [ "/run.sh" ]

# Labels
LABEL \
    io.hass.name="kodi-18-smb" \
    io.hass.description="KODI 18.9 with SMB rewrite" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/lpt2007" \
    org.label-schema.description="KODI 18.9 with SMB rewrite" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="kodi-18-smb-update" \
    org.label-schema.schema-version="dev-0.5.07a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb"
