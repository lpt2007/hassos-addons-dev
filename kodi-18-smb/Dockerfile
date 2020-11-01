FROM b01t/raspbian
##
MAINTAINER lpt2007 <mohyat@gmail.com>
##
### install minimal dependencies
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends xserver-xorg xinit \
     fbset \
     libraspberrypi0 \
     alsa-base \
     alsa-utils \
     alsa-tools \
     xserver-xorg-legacy \
     dbus-x11 \
     sudo \
     cifs-utils \
     jq \
     nano
##
### added pi user to sudders
#RUN adduser pi && \
#    echo "pi ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/pi && \
#    chmod 0440 /etc/sudoers.d/pi
##
### install latest kodi
#RUN su - pi -c "sudo apt-get install -y kodi" \
RUN apt-get install -y kodi \
#        kodi-peripheral-joystick \
#        kodi-pvr-iptvsimple \
#        kodi-inputstream-rtmp
##
### enabled for netflix addon
         kodi-inputstream-adaptive \
         python-pip \
         python-crypto \ 
         build-essential \
         python-all-dev \
         python-setuptools \
         python-wheel \
         python-crypto-dbg \
         python-crypto-doc \
         python-pip-whl
RUN pip install pycryptodomex
RUN ln -s /usr/lib/python2.7/dist-packages/Crypto /usr/lib/python2.7/dist-packages/Cryptodome
##
### enable tvservice
RUN apt-get update && apt-get install git build-essential cmake -y
RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice
##
#### configure Kodi group
RUN sudo usermod -a -G audio root && \
sudo usermod -a -G video root && \
sudo usermod -a -G input root && \
sudo usermod -a -G dialout root && \
sudo usermod -a -G plugdev root && \
sudo usermod -a -G tty root
##
### Copy data for add-on and make right privilages
COPY run.sh /
RUN chmod a+x /run.sh
##
### run kodi startup script
CMD [ "/run.sh" ]
