ARG PG_DOCKER_BASE=postgres:13-alpine
FROM ${PG_DOCKER_BASE}
ENV GOSU_VERSION 1.10

ADD ./gosu /usr/bin/
RUN chmod +x /usr/bin/gosu

RUN apk add --update iputils
RUN apk add --update htop


ARG TZ=UTC
ENV TZ ${TZ}

RUN apk upgrade --update \
  && apk add -U tzdata \
  && rm -rf \
  /var/cache/apk/*

# COPY ./setup-slave.sh /docker-entrypoint-initdb.d
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["gosu", "postgres", "postgres"]