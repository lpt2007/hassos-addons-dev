FROM b01t/raspbian

### install minimal dependencies
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends xserver-xorg xinit \
     fbset \
     libraspberrypi0 \
     cifs-utils \
     xserver-xorg-legacy \
     dbus-x11 \
     jq \
     nano

### install latest kodi
#RUN su - pi -c "sudo apt-get install -y kodi" \
RUN apt-get install -y kodi
#        kodi-peripheral-joystick \
#        kodi-pvr-iptvsimple \
#        kodi-inputstream-rtmp
##
### enabled for netflix addon
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
#RUN pip install pycryptodomex
#RUN ln -s /usr/lib/python2.7/dist-packages/Crypto /usr/lib/python2.7/dist-packages/Cryptodome
##
### enable tvservice
#RUN apt-get update && apt-get install git build-essential cmake -y
#RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
#RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice
##
#### configure Kodi group
#RUN sudo usermod -a -G audio root && \
#sudo usermod -a -G video root && \
#sudo usermod -a -G input root && \
#sudo usermod -a -G dialout root && \
#sudo usermod -a -G plugdev root && \
#sudo usermod -a -G tty root
##
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
    org.label-schema.schema-version="dev-0.5.06a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/kodi-18-smb"
