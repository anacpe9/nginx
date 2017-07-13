#!/bin/sh

set -e

echo "install new files ..."
cp -rf /nginx-src/nginx-container/* /var/nginx/
rm -rf /nginx-src/nginx-tools/
echo "install new files done"
