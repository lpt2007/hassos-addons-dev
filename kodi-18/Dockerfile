FROM b01t/raspbian
#kevin31/arm-kodi-gui

MAINTAINER lpt2007 <mohyat@gmail.com>

RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends xserver-xorg xinit \
     fbset \
     libraspberrypi0 \
     alsa-base \
     alsa-utils \
     alsa-tools \
     xserver-xorg-legacy \
     dbus-x11 \
     sudo

RUN adduser pi && \
    echo "pi ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/pi && \
    chmod 0440 /etc/sudoers.d/pi
 
RUN su - pi -c "sudo apt-get install -y kodi"
#        kodi-peripheral-joystick \
#        kodi-pvr-iptvsimple \
#        kodi-inputstream-adaptive \
#        kodi-inputstream-rtmp

# enable tvservice
RUN apt-get update && apt-get install git build-essential cmake -y
RUN cd /tmp && git clone http://github.com/raspberrypi/userland && sed -i 's/set(INSTALL_TARGETS "${INSTALL_TARGETS} vcilcs")/set(INSTALL_TARGETS ${INSTALL_TARGETS} vcilcs)/g' /tmp/userland/interface/vmcs_host/CMakeLists.txt && cd userland && ./buildme
RUN ln -s /opt/vc/bin/tvservice /usr/bin/tvservice

# configure Kodi group
RUN sudo usermod -a -G audio root && \
sudo usermod -a -G video root && \
sudo usermod -a -G input root && \
sudo usermod -a -G dialout root && \
sudo usermod -a -G plugdev root && \
sudo usermod -a -G tty root

# make kodi data directories
#RUN  mkdir -p /share/kodi-gui-new/data >/dev/null 2>&1 || true && rm -rf /home/pi/.kodi && ln -s /share/kodi-gui-new/data /home/pi/.kodi \
#    && mkdir -p /data >/dev/null 2>&1

#CMD ["bash","/usr/bin/kodi"]

#CMD ["su", "-", "pi", "-c", "/usr/bin/kodi"]
# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
