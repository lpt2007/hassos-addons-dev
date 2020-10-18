ARG BUILD_FROM=homeassistant/base
FROM ${BUILD_FROM}

RUN echo "[INFO] Installing TVHeadend"
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
RUN apk update && apk upgrade && apk add --update tvheadend git && rm -rf /var/cache/apk/*

RUN echo "[INFO] Starting TVHeadend"
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["/bin/bash", "-c", "/run.sh"]

# Labels
LABEL \
    io.hass.name="TVHeadend-new" \
    io.hass.description="TVHeadend Add-On" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/lpt2007" \
    org.label-schema.description="TVHeadend Add-On" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="TVHeadend-new" \
    org.label-schema.schema-version="0.27a" \
    org.label-schema.url="https://github.com/lpt2007/hassos-addons-dev/tvheadend-new" \
    org.label-schema.usage="https://github.com/lpt2007/hassos-addons-dev/tvheadend-new" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/lpt2007/hassos-addons-dev/tvheadend-new" \
    org.label-schema.vendor="https://github.com/lpt2007/hassos-addons-dev/tvheadend-new"
