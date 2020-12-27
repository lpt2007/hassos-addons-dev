FROM homeassistant/armhf-base-raspbian
#balenalib/raspberry-pi-debian
#homeassistant/armhf-base-raspbian
#b01t/raspbian:latest
##
MAINTAINER lpt2007 <mohyat@gmail.com>
##
### copy repository file and activate sources
#homeassistant/armhf-base-raspbian
RUN apt-get update && apt-get install -y wget
COPY /etc/apt/sources.list /etc/apt/sources.list
RUN chmod +x /etc/apt/sources.list
RUN wget https://archive.raspbian.org/raspbian.public.key -O - | apt-key add -
RUN wget https://archive.raspberrypi.org/debian/raspberrypi.gpg.key -O - | apt-key add -
##
### install minimal dependencies
RUN apt-get clean && apt-get update && apt-get upgrade -y 
#&& apt-get install -y --no-install-recommends xserver-xorg xinit \
#     fbset \
#     libraspberrypi0 \
#     xserver-xorg-legacy \
#     dbus-x11 \
#     sudo \
#     cifs-utils \
#     jq \
#     nano
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
### install kodi     
RUN apt-get install -y kodi
#
### enable tvservice
#RUN apt-get update && apt-get install git build-essential cmake -y
#RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
#RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice
#
### Copy data for add-on and make right privilages
COPY run.sh /run.sh
RUN chmod +x /run.sh
#
### add kodi roles
#COPY /etc/udev/rules.d/10-permissions.rules /etc/udev/rules.d/10-permissions.rules
#RUN chmod +x /etc/udev/rules.d/10-permissions.rules
#
#COPY /etc/udev/rules.d/10-permissions.rules /etc/udev/rules.d/99-input.rules
#RUN chmod +x /etc/udev/rules.d/99-input.rules
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
    org.label-schema.schema-version="dev-0.5.57a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb"
