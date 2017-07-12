FROM alpine:3.6

MAINTAINER Anucha Nualsi <n.anucha@er.co.th>

# https://github.com/gliderlabs/docker-alpine/issues/185
RUN mkdir -p /run/nginx && \
    apk update && \
    apk upgrade && \
    apk add --no-cache --update \
        nginx

CMD ["nginx", "-g", "daemon off;"]
