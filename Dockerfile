FROM alpine:3.6

MAINTAINER Anucha Nualsi <n.anucha@er.co.th>

# https://github.com/gliderlabs/docker-alpine/issues/185
RUN mkdir -p /run/nginx && \
    apk update && \
    apk upgrade && \
    apk add --no-cache --update \
        nginx && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/ssl/certs/ && \
    mkdir -p /usr/share/nginx/

CMD ["nginx", "-g", "daemon off;"]
