FROM alpine:3.16
LABEL maintainer="Anucha Nualsi <ana.cpe9@gmail.com>"

ENV NODE_TLS_REJECT_UNAUTHORIZED=0 \
    NODE_ENV=production \
    LANG=th_TH.utf8 \
    LANGUAGE=th_TH.utf8 \
    LC_CTYPE=th_US.utf8 \
    LC_ALL=th_TH.utf8

RUN apk update --no-cache && \
    apk add --no-cache --update \
    nginx=1.22.0-r0 \
    nginx-mod-http-headers-more \
    nginx-mod-http-brotli \
    tzdata && \
    cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
    echo "Asia/Bangkok" >  /etc/timezone && \
    apk del tzdata && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/*

EXPOSE 80
STOPSIGNAL SIGQUIT
CMD ["nginx", "-g", "daemon off;"]