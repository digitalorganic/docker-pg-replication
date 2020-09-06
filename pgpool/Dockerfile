# Pgpool2.

FROM alpine:edge

ENV LANG en_US.utf8

RUN apk add --no-cache curl pgpool py3-jinja2


ARG GOSU_VERSION=1.7
ENV GOSU_VERSION $GOSU_VERSION
ARG GOSU_DOWNLOAD_URL=https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64
ENV GOSU_DOWNLOAD_URL ${GOSU_DOWNLOAD_URL}

RUN curl -o /usr/local/bin/gosu -sSL ${GOSU_DOWNLOAD_URL} && \
    chmod +x /usr/local/bin/gosu

RUN mkdir /var/run/postgresql /var/log/postgresql /var/run/pgpool && \
    chown postgres /var/run/postgresql /etc/pgpool /var/log/postgresql /var/run/pgpool

# Post Install Configuration.
COPY bin/configure-pgpool2 /usr/bin/
RUN chmod +x /usr/bin/configure-pgpool2
ADD conf/pcp.conf.template /tmp/pcp.conf.template
ADD conf/pgpool.conf.template /tmp/pgpool.conf.template

# Start the container.
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9999 9898

CMD ["pgpool","-n", "-f", "/etc/pgpool/pgpool.conf", "-F", "/etc/pgpool/pcp.conf"]
