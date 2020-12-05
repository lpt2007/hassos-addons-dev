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
     
### build mesa drivers
RUN apt-get libgl1-mesa-dri
#build-dep
#libgl1-mesa-dri

RUN apt-get install \
    automake libtool \
    bison flex \
    gettext \
    libdrm-dev \
    libexpat1-dev \
    libudev-dev \
    libx11-xcb-dev \
    libxcb-dri3-dev \
    libxcb-dri2-0-dev \
    libxcb-glx0-dev \
    libxcb-xfixes0-dev \
    libxcb-present-dev \
    libxcb-sync-dev \
    libxshmfence-dev \
    libxdamage-dev \
    libxext-dev \
    libxfixes-dev \
    python-mako \
    x11proto-present-dev \
    x11proto-dri3-dev \
    x11proto-dri2-dev \
    x11proto-gl-dev

RUN git clone git://anongit.freedesktop.org/mesa/mesa
RUN cd mesa

RUN ./autogen.sh \
         --prefix=$HOME/prefix \
         --with-gallium-drivers=vc4 \
         --with-dri-drivers= \
         --with-egl-platforms=x11,drm

RUN make install

### install kodi     
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
    org.label-schema.name="kodi_18_smb_dev" \
    org.label-schema.schema-version="dev-0.5.21a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb"
