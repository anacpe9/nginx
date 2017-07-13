#!/bin/sh

set -e

cp -rf /nginx-src/nginx-container/* /var/nginx/
rm -rf /nginx-src/nginx-tools/
