#!/bin/sh

set -e

echo "remove old files ..."
rm -f /var/nginx/conf.d/th.ac.er.www.conf
rm -f /var/nginx/conf.d/ssl/ssl-th.ac.er.www.conf
rm -rf /var/nginx/html/th.ac.er.www/
echo "remove old files done."