ARG PG_DOCKER_BASE=postgres:13-alpine
FROM ${PG_DOCKER_BASE}

RUN apk add --update htop

ARG TZ=UTC
ENV TZ ${TZ}

RUN apk upgrade --update \
  && apk add -U tzdata \
  && rm -rf \
  /var/cache/apk/*

COPY ./setup-master.sh /docker-entrypoint-initdb.d/setup-master.sh

RUN chmod 0666 /docker-entrypoint-initdb.d/setup-master.sh