#!/bin/sh

set -e

cp -rf /nginx-container/* /usr/share/nginx/
rm -rf /nginx-tools/