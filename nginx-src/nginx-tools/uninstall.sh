#!/bin/sh

set -e

echo "remove old files ..."
rm -f /var/nginx/conf.d/th.co.er.www.conf
rm -f /var/nginx/conf.d/ssl/ssl-th.co.er.www.conf
rm -rf /var/nginx/html/th.co.er.www/
echo "remove old files done."
