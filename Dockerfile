FROM nginx:1.23.1-alpine
LABEL maintainer="Anucha Nualsi <ana.cpe9@gmail.com>"

ENV NODE_TLS_REJECT_UNAUTHORIZED=0 \
    NODE_ENV=production \
    LANG=th_TH.utf8 \
    LANGUAGE=th_TH.utf8 \
    LC_CTYPE=th_US.utf8 \
    LC_ALL=th_TH.utf8

RUN apk update --no-cache && \
    apk add --no-cache --update \
    tzdata && \
    cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
    echo "Asia/Bangkok" >  /etc/timezone && \
    apk del tzdata && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/*
