#!/bin/sh

set -e

cp -rf /nginx-container/* /var/nginx/
rm -rf /nginx-tools/