#!/bin/ash

#http://wiki.linuxwall.info/doku.php/en:ressources:dossiers:nginx:nginx_performance_tuning
FILETYPES="*.html *.woff *.css *.jpg *.jpeg *.gif *.png *.js"

#DIRECTORIES="/usr/share/nginx/html/"
DIRECTORIES="/nginx-src/nginx-container/html/"

for currentdir in $DIRECTORIES
do
   for i in $FILETYPES
   do
      find $currentdir -iname "$i" -exec ash -c 'PLAINFILE={};GZIPPEDFILE={}.gz; \
         if [ -e $GZIPPEDFILE ]; \
         then   if [ `stat -c %Y $PLAINFILE` -gt `stat -c %Y $GZIPPEDFILE` ]; \
                then    echo "$GZIPPEDFILE outdated, regenerating"; \
                        gzip -9 -f -c $PLAINFILE > $GZIPPEDFILE; \
                 fi; \
         else echo "$GZIPPEDFILE is missing, creating it"; \
              gzip -9 -c $PLAINFILE > $GZIPPEDFILE; \
         fi' \;
  done
done
