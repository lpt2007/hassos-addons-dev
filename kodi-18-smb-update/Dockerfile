ARG BUILD_FROM=homeassistant/armhf-base-raspbian
FROM ${BUILD_FROM}

# Set shell
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo "[INFO] install minimal dependencies"
#RUN apt-get clean && apt-get update
RUN apt-get install -y --no-install-recommends xserver-xorg xinit cifs-utils fbset
#                    libraspberrypi0
#                    alsa-base \
#                    alsa-utils \
#                    alsa-tools \
#                    xserver-xorg-legacy \
#                    dbus-x11 \
#                    sudo \
#                    jq \
#                    nano

RUN echo "[INFO] install latest kodi"
RUN apt-get install -y kodi
#        kodi-peripheral-joystick \
#        kodi-pvr-iptvsimple \
#        kodi-inputstream-rtmp
##
#RUN echo "[INFO] enabled for netflix addon"
#         kodi-inputstream-adaptive \
#         python-pip \
#         python-crypto \ 
#         build-essential \
#         python-all-dev \
#         python-setuptools \
#         python-wheel \
#         python-crypto-dbg \
#         python-crypto-doc \
#         python-pip-whl
#
#RUN pip install pycryptodomex
#RUN ln -s /usr/lib/python2.7/dist-packages/Crypto /usr/lib/python2.7/dist-packages/Cryptodome

#RUN echo "[INFO] enable tvservice"
#RUN apt-get update && apt-get install git build-essential cmake -y
#RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
#RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice

RUN echo "[INFO] Starting KODI"
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]

# Labels
LABEL \
    io.hass.name="kodi-18-smb-update" \
    io.hass.description="KODI 18.8 with SMB - updated form 0.4.4a" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/lpt2007" \
    org.label-schema.description="KODI 18.8 with SMB - updated form 0.4.4a" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="kodi-18-smb-update" \
    org.label-schema.schema-version="dev-0.4.431a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-update" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-update" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-update" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb-update"
