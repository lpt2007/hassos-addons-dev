ARG BUILD_FROM=linuxserver/tvheadend:latest
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
ARG BUILD_ARCH=amd64
RUN \
    if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64v8-latest"; fi \
    && if [ "${BUILD_ARCH}" = "armhf" ]; then ARCH="arm32v7-latest"; fi \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then ARCH="arm32v7-latest"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then ARCH="amd64-latest"; fi
#    \
#    && curl -L -s \
#        "https://github.com/portainer/portainer/releases/download/1.23.2/portainer-1.23.2-linux-${ARCH}.tar.gz" \
#        | tar zxvf - -C /opt/

#RUN echo "[INFO] Starting TVHeadend"
#COPY run.sh /run.sh
#RUN chmod +x /run.sh
#COPY setup_vlan.sh /setup_vlan.sh
#RUN chmod +x /setup_vlan.sh
#ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

RUN apk add --update vlan && rm -rf /var/cache/apk/*

# Labels
#LABEL \
#    io.hass.name="portainer" \
#    io.hass.description="Manage your Docker environment with ease" \
#    io.hass.arch="${BUILD_ARCH}" \
#    io.hass.type="addon" \
#    io.hass.version=${BUILD_VERSION} \
#    maintainer="Franck Nijhof <frenck@addons.community>" \
#    org.label-schema.description="Manage your Docker environment with ease" \
#    org.label-schema.build-date=${BUILD_DATE} \
#    org.label-schema.name="Portainer" \
#    org.label-schema.schema-version="1.0" \
#    org.label-schema.url="https://community.home-assistant.io/t/home-assistant-community-add-on-portainer/68836?u=frenck" \
#    org.label-schema.usage="https://github.com/hassio-addons/addon-portainer/tree/master/README.md" \
#    org.label-schema.vcs-ref=${BUILD_REF} \
#    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-portainer" \
#    org.label-schema.vendor="Home Assistant Community Add-ons"
