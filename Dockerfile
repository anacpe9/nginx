FROM alpine:3.6

MAINTAINER Anucha Nualsi <n.anucha@er.co.th>

COPY nginx-src /nginx-src

# https://github.com/gliderlabs/docker-alpine/issues/185
RUN mkdir -p /run/nginx/ && \
    mkdir -p /etc/ssl/certs/ && \
    #mkdir -p /var/nginx/ && \
    #mkdir -p /var/nginx/logs/ && \
    #mkdir -p /var/nginx/html/ && \
    #mkdir -p /var/nginx/config/ && \    
    #mkdir -p /var/nginx/ssl/snippets/ && \
    apk update && \
    apk upgrade && \
    apk add --no-cache --update \
        nginx && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/* && \
    cp -f /nginx-src/nginx-container/nginx.conf /etc/nginx/ && \
    chmod a+x /nginx-src/nginx-tools/gzip_static.sh && \
    chmod a+x /nginx-src/nginx-tools/install.sh && \
    chmod a+x /nginx-src/nginx-tools/uninstall.sh && \
    chmod a+x /nginx-src/nginx-tools/restall.sh && \
    mkdir -p /var/tmp/nginx/client_body/ && \
    echo "ls -l /run/nginx/" && \
    ls -l /run/nginx/ && \
    echo "ls -l /var/tmp/nginx/client_body/" && \
    ls -l /var/tmp/nginx/client_body/ && \
    echo "ls -l /etc/ssl/certs/" && \    
    ls -l /etc/ssl/certs/ && \
    /nginx-src/nginx-tools/gzip_static.sh

CMD ["nginx", "-g", "daemon off;"]
