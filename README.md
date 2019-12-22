# Alpine Base
## Introduction
This is the alpine base image of the Hacking-Lab CTF system

## Specifications
* based on alpine latest
* with s6 startup handling
* with dynamic ctf flag handling in `environment variables`
* with dynamic ctf flag handling in `files`


## Template `docker-compose.yml`
```
version: '3.4'

services:
  alpine-base-hobo:
    image: REGISTRY_BASE_URL/alpine-base:latest
    hostname: 'hobo'
    environment:
      - "domainname=idocker.REALM_DOMAIN_SUFFIX"
    labels:
      - "traefik.port=80"
      - "traefik.frontend.rule=Host:hobo.REALM_DOMAIN_SUFFIX"
      - "traefik.protocol=http"
    env_file:
      - ./UUID.env
    volumes:
      - ./UUID.gn:/goldnugget/UUID.gn
```

## TESTING `alpine-base-example`
* UUID = 6db3a534-70eb-40e5-8d6f-9839b46b53fb
* example subfolder in ./alpine-base/alpine-base-example

```
ibuetler@demide:/opt/git/alpine-base/alpine-base-example$ cd /opt/git/alpine-base/

ibuetler@demide:/opt/git/alpine-base$ ls -al 
total 56
drwxr-xr-x  6 ibuetler ibuetler 4096 Dez 22 13:41 .
drwxr-xr-x 14 ibuetler ibuetler 4096 Dez 22 12:43 ..
drwxr-xr-x  3 ibuetler ibuetler 4096 Dez 22 13:43 alpine-base-example
-rwxr-xr-x  1 ibuetler ibuetler   66 Dez 22 12:42 build.sh
-rw-r--r--  1 ibuetler ibuetler  405 Dez 22 13:41 docker-compose.yml
-rw-r--r--  1 ibuetler ibuetler  885 Dez 22 12:42 Dockerfile
drwxr-xr-x  2 ibuetler ibuetler 4096 Dez 22 12:42 flag-deploy-scripts
drwxr-xr-x  8 ibuetler ibuetler 4096 Dez 22 12:42 .git
-rw-r--r--  1 ibuetler ibuetler 8297 Dez 22 13:41 README.md
drwxr-xr-x  4 ibuetler ibuetler 4096 Dez 22 12:42 root
-rw-r--r--  1 ibuetler ibuetler   26 Dez 22 12:42 UUID.env
-rw-r--r--  1 ibuetler ibuetler   26 Dez 22 12:42 UUID.gn

ibuetler@demide:/opt/git/alpine-base$ cd alpine-base-example

ibuetler@demide:/opt/git/alpine-base/alpine-base-example$ ls -al 
total 28
drwxr-xr-x 3 ibuetler ibuetler 4096 Dez 22 13:43 .
drwxr-xr-x 6 ibuetler ibuetler 4096 Dez 22 13:41 ..
-rw-r--r-- 1 ibuetler ibuetler   26 Dez 22 12:42 6db3a534-70eb-40e5-8d6f-9839b46b53fb.env
-rw-r--r-- 1 ibuetler ibuetler   26 Dez 22 12:42 6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
-rw-r--r-- 1 ibuetler ibuetler  290 Dez 22 13:42 docker-compose.yml
-rw-r--r-- 1 ibuetler ibuetler  885 Dez 22 12:42 Dockerfile
drwxr-xr-x 5 ibuetler ibuetler 4096 Dez 22 13:43 root

```

Content of `docker-compose.yml` with a real UUID
```
ibuetler@demide:/opt/git/alpine-base/alpine-base-example$ cat docker-compose.yml 
version: '3.4'

services:
  alpine-base:
    image: hackinglab/alpine-base:latest
    hostname: 'alpine-base'
    env_file:
      - ./6db3a534-70eb-40e5-8d6f-9839b46b53fb.env
    volumes:
      - ./6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn:/goldnugget/6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
```

Content of UUID.env (do not change this!!!)
```
ibuetler@demide:~/Repository/alpine-base-example$ cat 6db3a534-70eb-40e5-8d6f-9839b46b53fb.env 
GOLDNUGGET=SED_GOLDNUGGET
```

Content of UUID.gn (do not change this!!!)
```
ibuetler@demide:~/Repository/alpine-base-example$ cat 6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
GOLDNUGGET=SED_GOLDNUGGET
```

Content of `flag-deploy-scripts` folder
* deploy-env-flag.sh = your code how you want to deploy the flag in the CTF docker
* deploy-file-flag.sh = your code how you want to deploy the flag in the CTF docker

```
ibuetler@demide:~/Repository/alpine-base-example$ ls -al flag-deploy-scripts/
total 16
drwx------ 2 ibuetler ibuetler 4096 Dez 10 09:58 .
drwxr-xr-x 4 ibuetler ibuetler 4096 Dez 10 09:59 ..
-rwx------ 1 ibuetler ibuetler   89 Dez 10 09:58 deploy-env-flag.sh
-rwx------ 1 ibuetler ibuetler   90 Dez 10 09:58 deploy-file-flag.sh
```


## BUILDING with `docker build`
```
root@demide:/opt/git/alpine-base/alpine-base-example# bash build.sh 
Sending build context to Docker daemon  23.55kB
Step 1/11 : FROM alpine:latest
 ---> c85b8f829d1f
Step 2/11 : MAINTAINER Ivan Buetler <ivan.buetler@compass-security.com>
 ---> Running in 345cb48af00d
Removing intermediate container 345cb48af00d
 ---> 3368b2fce988
Step 3/11 : ENV S6_OVERLAY_VERSION=v1.22.1.0     GO_DNSMASQ_VERSION=1.0.7
 ---> Running in 9403fbf9b52a
Removing intermediate container 9403fbf9b52a
 ---> 73218e10b8fa
Step 4/11 : RUN apk add --update --no-cache bind-tools curl libcap bash net-tools openssl
 ---> Running in 40c2ba38001f
fetch http://dl-cdn.alpinelinux.org/alpine/v3.11/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.11/community/x86_64/APKINDEX.tar.gz
(1/29) Installing ncurses-terminfo-base (6.1_p20191130-r0)
(2/29) Installing ncurses-terminfo (6.1_p20191130-r0)
(3/29) Installing ncurses-libs (6.1_p20191130-r0)
(4/29) Installing readline (8.0.1-r0)
(5/29) Installing bash (5.0.11-r1)
Executing bash-5.0.11-r1.post-install
(6/29) Installing fstrm (0.6.0-r1)
(7/29) Installing libgcc (9.2.0-r3)
(8/29) Installing krb5-conf (1.0-r1)
(9/29) Installing libcom_err (1.45.4-r0)
(10/29) Installing keyutils-libs (1.6.1-r0)
(11/29) Installing libverto (0.3.1-r1)
(12/29) Installing krb5-libs (1.17.1-r0)
(13/29) Installing json-c (0.13.1-r0)
(14/29) Installing libstdc++ (9.2.0-r3)
(15/29) Installing libprotobuf (3.11.2-r0)
(16/29) Installing libprotoc (3.11.2-r0)
(17/29) Installing protobuf-c (1.3.2-r3)
(18/29) Installing xz-libs (5.2.4-r0)
(19/29) Installing libxml2 (2.9.10-r1)
(20/29) Installing bind-libs (9.14.8-r5)
(21/29) Installing bind-tools (9.14.8-r5)
(22/29) Installing ca-certificates (20191127-r0)
(23/29) Installing nghttp2-libs (1.40.0-r0)
(24/29) Installing libcurl (7.67.0-r0)
(25/29) Installing curl (7.67.0-r0)
(26/29) Installing libcap (2.27-r0)
(27/29) Installing mii-tool (1.60_git20140218-r2)
(28/29) Installing net-tools (1.60_git20140218-r2)
(29/29) Installing openssl (1.1.1d-r2)
Executing busybox-1.31.1-r8.trigger
Executing ca-certificates-20191127-r0.trigger
OK: 30 MiB in 43 packages
Removing intermediate container 40c2ba38001f
 ---> 88a94eb0faf0
Step 5/11 : RUN apk upgrade --available
 ---> Running in 0b355374e58f
fetch http://dl-cdn.alpinelinux.org/alpine/v3.11/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.11/community/x86_64/APKINDEX.tar.gz
OK: 30 MiB in 43 packages
Removing intermediate container 0b355374e58f
 ---> 31296c5edd38
Step 6/11 : RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C /
 ---> Running in 7ae6e4739cf2
Removing intermediate container 7ae6e4739cf2
 ---> 289366de6002
Step 7/11 : RUN echo "========="
 ---> Running in ef5539c20cf2
=========
Removing intermediate container ef5539c20cf2
 ---> 1262fbb04b00
Step 8/11 : RUN curl -sSL https://github.com/janeczku/go-dnsmasq/releases/download/${GO_DNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /bin/go-dnsmasq &&     chmod +x /bin/go-dnsmasq &&     apk del curl &&     addgroup go-dnsmasq &&     adduser -D -g "" -s /bin/sh -G go-dnsmasq go-dnsmasq &&     setcap CAP_NET_BIND_SERVICE=+eip /bin/go-dnsmasq
 ---> Running in 5b50670cca3e
(1/4) Purging curl (7.67.0-r0)
(2/4) Purging libcurl (7.67.0-r0)
(3/4) Purging ca-certificates (20191127-r0)
Executing ca-certificates-20191127-r0.post-deinstall
(4/4) Purging nghttp2-libs (1.40.0-r0)
Executing busybox-1.31.1-r8.trigger
OK: 28 MiB in 39 packages
Removing intermediate container 5b50670cca3e
 ---> f9df86d4d41b
Step 9/11 : COPY root /
 ---> ff500af0e10a
Step 10/11 : ENTRYPOINT ["/init"]
 ---> Running in 692cfbb2e288
Removing intermediate container 692cfbb2e288
 ---> 04245af77581
Step 11/11 : CMD []
 ---> Running in b182514f8df4
Removing intermediate container b182514f8df4
 ---> 4a2a20e59407
Successfully built 4a2a20e59407
Successfully tagged hackinglab/alpine-base:latest

```


## TESTING docker-compose.yml using `docker-compose config`
```
root@demide:/opt/git/alpine-base/alpine-base-example# docker-compose config
services:
  alpine-base:
    environment:
      GOLDNUGGET: SED_GOLDNUGGET
    hostname: alpine-base
    image: hackinglab/alpine-base:latest
    volumes:
    - /opt/git/alpine-base/alpine-base-example/6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn:/goldnugget/6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn:rw
version: '3.4'

```

## RUNNING container using `docker-compose up`
```
root@demide:/opt/git/alpine-base/alpine-base-example# docker-compose up
Creating network "alpine-base-example_default" with the default driver
Creating alpine-base-example_alpine-base_1 ... done
Attaching to alpine-base-example_alpine-base_1
alpine-base_1  | [s6-init] making user provided files available at /var/run/s6/etc...exited 0.
alpine-base_1  | [s6-init] ensuring user provided files have correct perms...exited 0.
alpine-base_1  | [fix-attrs.d] applying ownership & permissions fixes...
alpine-base_1  | [fix-attrs.d] 01-resolver-resolv: applying... 
alpine-base_1  | [fix-attrs.d] 01-resolver-resolv: exited 0.
alpine-base_1  | [fix-attrs.d] done.
alpine-base_1  | [cont-init.d] executing container initialization scripts...
alpine-base_1  | [cont-init.d] 10-adduser: executing... 
alpine-base_1  | =================================
alpine-base_1  | 
alpine-base_1  | =================================
alpine-base_1  | USERNAME not defined - will use default username hacker
alpine-base_1  | chpasswd: password for 'root' changed
alpine-base_1  | chpasswd: password for 'hacker' changed
alpine-base_1  | 
alpine-base_1  | -------------------------------------
alpine-base_1  | GID/UID
alpine-base_1  | -------------------------------------
alpine-base_1  | User uid:    2000
alpine-base_1  | User gid:    2000
alpine-base_1  | -------------------------------------
alpine-base_1  | 
alpine-base_1  | [cont-init.d] 10-adduser: exited 0.
alpine-base_1  | [cont-init.d] 30-resolver: executing... 
alpine-base_1  | [cont-init.d] 30-resolver: exited 0.
alpine-base_1  | [cont-init.d] 40-resolver: executing... 
alpine-base_1  | [cont-init.d] 40-resolver: exited 0.
alpine-base_1  | [cont-init.d] 99-add-flag: executing... 
alpine-base_1  | 
alpine-base_1  | ====== testing for flag in environment variable =======
alpine-base_1  | flag found in environment variable GOLDNUGGET=SED_GOLDNUGGET
alpine-base_1  | what do you want to do with the flag in the environment variable?
alpine-base_1  | please define what you want to do with the flag in /flag-deploy-scripts/deploy-env-flag.sh
alpine-base_1  | executing /flag-deploy-scripts/deploy-env-flag.sh
alpine-base_1  | put your commands to deploy the env based flag here
alpine-base_1  | the variable $GOLDNUGGET contains the dynamic flag
alpine-base_1  | 
alpine-base_1  | ====== testing for flag in /goldnugget folder ======
alpine-base_1  | flag file found in /goldnugget
alpine-base_1  | total 4
alpine-base_1  | -rw-r--r--    1 go-dnsma go-dnsma        26 Dec 22 11:42 6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
alpine-base_1  | what do you want to do with the flag file?
alpine-base_1  | please define what you want to do with the flag in /flag-deploy-scripts/deploy-file-flag.sh
alpine-base_1  | executing /flag-deploy-scripts/deploy-file-flag.sh
alpine-base_1  | put your commands to deploy the file based flag here
alpine-base_1  | the /goldnugget/*.gn contains the flag
alpine-base_1  | 
alpine-base_1  | =============================================
alpine-base_1  | [cont-init.d] 99-add-flag: exited 0.
alpine-base_1  | [cont-init.d] done.
alpine-base_1  | [services.d] starting services
alpine-base_1  | [services.d] done.

```

## Conclusion
The alpine-base image is the foundation of all other Alpine Linux based CTF docker images. Thus, we do not really have a flag in the alpine-base image. 

## Who takes care of the flag? 
Hacking-Lab CTF docker containers are spinned up by a service called `docker manager`. The `docker manager` will create a random token `uuid` will create random values and sets the flags throughout the ENV or FILE attribute.





