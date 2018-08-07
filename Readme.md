# Nginx

## โครงสร้างหลัก

```text
/etc/ssl/certs/
/etc/nginx/config.conf ---------------------------> <default main configuration file>
/var/nginx/
  |-- config/
  |   |-- nginx.pre-ssl.conf ---------------------> <use for setting letsencrypt>
  |   |-- conf.d/
  |       |-- th.ac.er.www.config ----------------> vhost server block config file
  |       `-- th.ac.er.test.config
  |   |-- ssl/
  |       |-- dhparam.pem
  |       `-- snippets/
  |           |-- ssl-params.conf
  |           |-- ssl-th.ac.er.test.conf
  `-- html/
      |-- th.ac.er.www <default>
      |-- th.ac.er.test <others> -----------------> <plug-in vhost>
      `-- th.ac.er.test_app1 <virtual path> ------> <plug-in vhost>
```

ถ้าเข้าใช้งานครั้งแรกต้อง login เข้า docker registry ก่อน

```shell
docker login registry.er.co.th:443
```

## First installation

ติดตั้งไฟล์ลงบน host

```shell
mkdir -p /var/nginx/ && \
mkdir -p /etc/ssl/certs/ && \
mkdir -p /etc/letsencrypt/webconfig/ && \
mkdir -p /etc/letsencrypt/webrootauth/ && \

docker pull registry.er.co.th:443/ops/nginx-webserver:latest && \
docker run -it --rm \
       --volume /var/nginx:/var/nginx:rw \
       --volume /etc/letsencrypt:/etc/letsencrypt:rw \
       registry.er.co.th:443/ops/nginx-webserver:latest \
       /nginx-src/nginx-tools/install.sh
```

```shell
docker pull registry.er.co.th:443/ops/nginx-webserver:latest && \
docker run -d \
       --restart always \
       --name nginx-webserver \
       --publish 80:80 \
       --publish 443:443 \
       --volume /var/log/nginx:/var/log/nginx:rw \
       --volume /var/nginx:/var/nginx:ro \
       --volume /etc/letsencrypt:/etc/letsencrypt:ro \
       --volume /etc/ssl/certs/dhparam.pem:/etc/ssl/certs/dhparam.pem:ro \
       registry.er.co.th:443/ops/nginx-webserver:latest
```

หากมีการติดตั้ง plug-in vhost หลักจากนี้  
ให้สั่ง gzip สำหรับ gzip_static on
และ nginx reload configuration ใหม่

```shell
#docker exec -it webserver /nginx-src/nginx-tools/gzip_static.sh
docker exec -it nginx-webserver nginx -s reload
```

### ลบไฟล์
```shell
docker run -it --rm \
       --volume /var/nginx:/var/nginx:rw \
       --volume /etc/letsencrypt:/etc/letsencrypt:rw \
       registry.er.co.th:443/ops/nginx-webserver:latest \
       /nginx-src/nginx-tools/uninstall.sh
```

### One-Shot command

```shell
$(docker pull registry.er.co.th:443/ops/nginx-webserver:latest | grep -q 'Image is up to date') || \
(echo "must reinstall new version." && \
docker run -it --rm \
       --volume /var/nginx:/var/nginx:rw \
       --volume /etc/letsencrypt:/etc/letsencrypt:rw \
       registry.er.co.th:443/ops/nginx-webserver:latest \
       /nginx-src/nginx-tools/reinstall.sh && \
echo "docker stop nginx-webserver" && \
docker stop nginx-webserver && \
echo "docker rm nginx-webserver" && \
docker rm nginx-webserver && \
docker run -d \
       --restart always \
       --name nginx-webserver \
       --publish 80:80 \
       --publish 443:443 \
       --volume /var/nginx:/var/nginx:ro \
       --volume /etc/letsencrypt:/etc/letsencrypt:ro \
       --volume /etc/ssl/certs/dhparam.pem:/etc/ssl/certs/dhparam.pem:ro \
       registry.er.co.th:443/ops/nginx-webserver:latest
)
```

#### Refernce

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
* https://lab.er.co.th/help/ssh/README

* http://www.carlboettiger.info/2014/08/29/docker-notes.html
* https://blogs.msdn.microsoft.com/cesardelatorre/2016/11/18/summary-of-official-microsoft-docker-images-for-net-core-and-net-framework/
* https://github.com/dotnet/coreclr/issues/917

* https://blog.anynines.com/mastering-continuous-integration-and-continuous-deployment-with-gitlab/
* https://lab.er.co.th/help/ci/yaml/README.md

### Tunnig Nginx

* [Nginx Optimization: understanding sendfile, tcp_nodelay and tcp_nopush](https://t37.net/nginx-optimization-understanding-sendfile-tcp_nodelay-and-tcp_nopush.html)
* [Tuning Nginx for Best Performance](http://dak1n1.com/blog/12-nginx-performance-tuning/)
* [Nginx Optimization – The Definitive Guide](https://www.scalescale.com/tips/nginx/nginx-optimization-the-definitive-guide/)
* [How to Configure nginx for Optimized Performance](https://www.linode.com/docs/web-servers/nginx/configure-nginx-for-optimized-performance)
* [How To Optimize Nginx Configuration](https://www.digitalocean.com/community/tutorials/how-to-optimize-nginx-configuration)
* [Tuning NGINX for Performance](https://www.nginx.com/blog/tuning-nginx/)
* [How to Monitor Nginx: The Essential Guide](https://www.scalyr.com/community/guides/how-to-monitor-nginx-the-essential-guide)
