**โครงสร้างหลัก**
```
/etc/ssl/certs/
/etc/nginx/config.conf ---------------------------> <default main configuration file>
/usr/share/nginx/
  |-- config/
  |   |-- nginx.pre-ssl.conf ---------------------> <use for setting letsencrypt>
  |   |-- conf.d/
  |       |-- th.ac.er.www.config ---------------> vhost server block config file
  |       `-- th.ac.er.test.config
  |   |-- ssl/
  |       |-- dhparam.pem
  |       `-- snippets/
  |           |-- ssl-params.conf
  |           |-- ssl-th.ac.er.test.conf
  |-- logs/
  `-- html/
      |-- th.ac.er.www <default>
      |-- th.ac.er.test <others> -----------------> <plug-in vhost>
      `-- th.ac.er.test_app1 <virtual path> ------> <plug-in vhost>
```

ถ้าเข้าใช้งานครั้งแรกต้อง login เข้า docker registry ก่อน
```shell
docker login registry.er.co.th:443
```

**First installation**
ติดตั้งไฟล์ลงบน host
```shell
mkdir -p /etc/ssl/certs/
mkdir -p /usr/share/nginx/
mkdir -p /etc/letsencrypt/webconfig/
mkdir -p /etc/letsencrypt/webrootauth/

docker run -it --rm \
       --name webserver \
       --volume /usr/share/nginx:/usr/share/nginx:rw \
       --volume /etc/letsencrypt:/etc/letsencrypt:rw \
       registry.er.co.th:443/er.co.th/www:latest \
       /install.sh
```

```shell
docker run -d \
       --name webserver \
       --publish 80:80 \
       --publish 443:443 \
       --volume /usr/share/nginx:/usr/share/nginx:ro \
       --volume /etc/letsencrypt:/etc/letsencrypt:ro \
       --volume /etc/ssl/certs/dhparam.pem:/etc/ssl/certs/dhparam.pem:ro
       registry.er.co.th:443/er.co.th/www:latest
```

หากมีการติดตั้ง plug-in vhost หลักจากนี้   
ให้สั่ง gzip สำหรับ gzip_static on
และ nginx reload configuration ใหม่
```shell
#docker exec -it webserver /gzip_static.sh
docker exec -it webserver nginx -s reload
```

**Refernce**
* https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-16-04
* https://publications.jbfavre.org/web/nginx-vhosts-automatiques-avec-SSL-et-authentification.en
* https://publications.jbfavre.org/web/nginx-vhosts-automatiques-avec-SSL-et-authentification-version2.en
* https://t37.net/the-good-the-bad-and-the-ugly-of-virtual-hosting-with-nginx.html
* https://nvbn.github.io/2015/01/25/docker-nginx/


* http://blog.xebia.com/create-the-smallest-possible-docker-container/
* https://medium.com/@adriaandejonge/simplify-the-smallest-possible-docker-image-62c0e0d342ef
* https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/
* http://www.blang.io/posts/2015-04_how-to-build-the-smallest-docker-containers/
* https://www.brianchristner.io/docker-image-base-os-size-comparison/


* https://medium.com/@ramangupta/why-docker-data-containers-are-good-589b3c6c749e
* https://docs.docker.com/engine/tutorials/dockervolumes/
* https://theartofmachinery.com/2016/06/06/nginx_gzip_static.html
* http://wiki.linuxwall.info/doku.php/en:ressources:dossiers:nginx:nginx_performance_tuning


* https://docs.gitlab.com/ee/ci/ssh_keys/README.html
* https://docs.gitlab.com/ce/ci/ssh_keys/README.html#ssh-keys-when-using-the-docker-executor
* https://gitlab.com/gitlab-examples/ssh-private-key/blob/master/.gitlab-ci.yml
* https://forum.gitlab.com/t/ssh-keys-inside-dockerfile/5622/2
