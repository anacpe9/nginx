FROM alpine:3.6

MAINTAINER Anucha Nualsi <n.anucha@er.co.th>

COPY nginx-src /nginx-tools

# https://github.com/gliderlabs/docker-alpine/issues/185
RUN mkdir -p /run/nginx && \
    mkdir -p /etc/ssl/certs/ && \
    mkdir -p /usr/share/nginx/ && \
    mkdir -p /usr/share/nginx/logs/ && \
    mkdir -p /usr/share/nginx/html/ && \
    mkdir -p /usr/share/nginx/config/ && \    
    mkdir -p /usr/share/nginx/ssl/snippets/ && \
    apk update && \
    apk upgrade && \
    apk add --no-cache --update \
        nginx && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/* && \
    ls -ln / && \
    /nginx-tools/gzip_static.sh

CMD ["nginx", "-g", "daemon off;"]
