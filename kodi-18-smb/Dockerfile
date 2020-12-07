FROM balenalib/raspberry-pi-debian
#homeassistant/armhf-base-raspbian
#b01t/raspbian
##
MAINTAINER lpt2007 <mohyat@gmail.com>
##
### install minimal dependencies
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends xserver-xorg xinit \
     fbset \
     libraspberrypi0 \
     xserver-xorg-legacy \
     dbus-x11 \
     sudo \
     cifs-utils \
     jq \
     nano
### vc4 drivers
#libdrm-amdgpu1 \
#libdrm-common  \
#libdrm-nouveau2 \
#libdrm-radeon1 \
#libdrm2 \
#libglapi-mesa \
#libllvm9 \
#libsensors-config \
#libsensors5
#
#lm-sensors
#
#gldriver-test
#libbgl1-mesa-dri
#
### mesa drivers
#RUN apt-get install -y libxcb-randr0-dev libxrandr-dev \
#        libxcb-xinerama0-dev libxinerama-dev libxcursor-dev \
#        libxcb-cursor-dev libxkbcommon-dev xutils-dev \
#        xutils-dev libpthread-stubs0-dev libpciaccess-dev \
#        libffi-dev x11proto-xext-dev libxcb1-dev libxcb-*dev \
#        bison flex libssl-dev libgnutls28-dev x11proto-dri2-dev \
#        x11proto-dri3-dev libx11-dev libxcb-glx0-dev \
#        libx11-xcb-dev libxext-dev libxdamage-dev libxfixes-dev \
#        libva-dev x11proto-randr-dev x11proto-present-dev \
#        libclc-dev libelf-dev git build-essential mesa-utils \
#        libvulkan-dev ninja-build libvulkan1 python-mako \
#        libdrm-dev libxshmfence-dev libxxf86vm-dev \
#        python3-mako
#        
#RUN apt-get install -y python3-pip        
#RUN pip3 install meson
#
#RUN git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa
#RUN cd mesa
#RUN git checkout wip/igalia/v3dv
#RUN meson --prefix /home/pi/local-install --libdir lib -Dplatforms=x11,drm -Dvulkan-drivers=broadcom -Ddri-drivers= -Dgallium-drivers=v3d,kmsro,vc4 -Dbuildtype=debug _build
#RUN ninja -C _build
#RUN ninja -C _build install
#
### install kodi     
RUN apt-get install -y kodi
#
### enable tvservice
RUN apt-get update && apt-get install git build-essential cmake -y
RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice
#
### Copy data for add-on and make right privilages
COPY run.sh /run.sh
RUN chmod +x /run.sh
#
### run kodi startup script
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]
#
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
    org.label-schema.schema-version="dev-0.5.33a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb"
