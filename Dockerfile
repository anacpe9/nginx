FROM alpine:3.8

LABEL maintainer="Anucha Nualsi <ana.cpe9@gmail.com>"

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
    "nginx=1.14.0-r0" && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/apk/* && \
    cp -f /nginx-src/nginx-container/nginx.conf /etc/nginx/ && \
    mkdir -p /nginx-src/nginx-container/html/ && \
    chmod a+x /nginx-src/nginx-tools/gzip_static.sh && \
    chmod a+x /nginx-src/nginx-tools/install.sh && \
    chmod a+x /nginx-src/nginx-tools/uninstall.sh && \
    chmod a+x /nginx-src/nginx-tools/reinstall.sh && \
    mkdir -p /var/tmp/nginx/client_body/ && \
    echo "ls -l /run/nginx/" && \
    ls -l /run/nginx/ && \
    echo "ls -l /var/tmp/nginx/client_body/" && \
    ls -l /var/tmp/nginx/client_body/ && \
    echo "ls -l /etc/ssl/certs/" && \    
    ls -l /etc/ssl/certs/ && \
    nginx -t && \
    nginx -v

CMD ["nginx", "-g", "daemon off;"]
