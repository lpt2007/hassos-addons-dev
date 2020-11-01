FROM b01t/raspbian
##
MAINTAINER lpt2007 <mohyat@gmail.com>
##
### install minimal dependencies
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends xserver-xorg xinit \
     fbset \
     libraspberrypi0 \
     xserver-xorg-legacy \
     dbus-x11 \
     sudo \
     cifs-utils \
     jq \
     nano
     
RUN apt-get install -y kodi

### enable tvservice
RUN apt-get update && apt-get install git build-essential cmake -y
RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice

### Copy data for add-on and make right privilages
COPY run.sh /run.sh
RUN chmod +x /run.sh

### run kodi startup script
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]

### Labels
LABEL \
    io.hass.name="kodi-18-smb" \
    io.hass.description="KODI 18.7 with SMB rewrite" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/lpt2007" \
    org.label-schema.description="KODI 18.7 with SMB rewrite" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="kodi-18-smb-update" \
    org.label-schema.schema-version="dev-0.5.10a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb"
