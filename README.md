# Alpine Base
## Introduction
This is the alpine base image of the Hacking-Lab CTF system

## Specifications
* based on alpine latest
* with s6 startup handling
* with dynamic ctf flag handling in `environment variables`
* with dynamic ctf flag handling in `files`


## Template DEVELOPMENT docker-compose.yml for Hacking-Lab 2.0 CTF
```
version: '3.4'

services:
  alpine-base:
    image: ibuetler/alpine-base:latest
    hostname: 'alpine-base'
    env_file:
      - ./UUID.env
    volumes:
      - ./UUID.gn:/goldnugget/UUID.gn
      - ./flag-deploy-scripts:/flag-deploy-scripts
```

## WORKING DEVELOPMENT docker-compose.yml for Hacking-Lab 2.0 CTF
```
version: '3.4'

services:
  alpine-base:
    image: ibuetler/alpine-base:latest
    hostname: 'alpine-base'
    env_file:
      - ./6db3a534-70eb-40e5-8d6f-9839b46b53fb.env
    volumes:
      - ./6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn:/goldnugget/UUID.gn
      - ./flag-deploy-scripts:/flag-deploy-scripts
```

## Building DEVELOPMENT release of alpine-base 
* UUID = 6db3a534-70eb-40e5-8d6f-9839b46b53fb

```
ibuetler@demide:~/Repository/alpine-base-example$ ls -al 
total 32
drwxr-xr-x  4 ibuetler ibuetler 4096 Dez 10 09:59 .
drwxr-xr-x 24 ibuetler ibuetler 4096 Dez 10 09:58 ..
-rw-r--r--  1 ibuetler ibuetler   26 Dez 10 09:58 6db3a534-70eb-40e5-8d6f-9839b46b53fb.env
-rw-r--r--  1 ibuetler ibuetler   26 Dez 10 09:58 6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
-rw-r--r--  1 ibuetler ibuetler  306 Dez 10 10:04 docker-compose.yml
-rw-r--r--  1 ibuetler ibuetler  885 Dez 10 09:58 Dockerfile
drwx------  2 ibuetler ibuetler 4096 Dez 10 09:58 flag-deploy-scripts
drwxr-xr-x  5 ibuetler ibuetler 4096 Dez 10 09:58 root
```

Content of the files gn, env, and directory flag-deploy-scripts

```
ibuetler@demide:~/Repository/alpine-base-example$ cat 6db3a534-70eb-40e5-8d6f-9839b46b53fb.env 
GOLDNUGGET=SED_GOLDNUGGET

ibuetler@demide:~/Repository/alpine-base-example$ cat 6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
GOLDNUGGET=SED_GOLDNUGGET

ibuetler@demide:~/Repository/alpine-base-example$ ls -al flag-deploy-scripts/
total 16
drwx------ 2 ibuetler ibuetler 4096 Dez 10 09:58 .
drwxr-xr-x 4 ibuetler ibuetler 4096 Dez 10 09:59 ..
-rwx------ 1 ibuetler ibuetler   89 Dez 10 09:58 deploy-env-flag.sh
-rwx------ 1 ibuetler ibuetler   90 Dez 10 09:58 deploy-file-flag.sh
```

## BUILDING with `docker build`
```
root@demide:/home/ibuetler/Repository/alpine-base-example# docker build -t hackinglab/alpine-base  .
Sending build context to Docker daemon  23.04kB
Step 1/11 : FROM alpine:latest
 ---> 965ea09ff2eb
Step 2/11 : MAINTAINER Ivan Buetler <ivan.buetler@compass-security.com>
 ---> Using cache
 ---> ee5378933db1
Step 3/11 : ENV S6_OVERLAY_VERSION=v1.22.1.0     GO_DNSMASQ_VERSION=1.0.7
 ---> Using cache
 ---> 34c18413045d
Step 4/11 : RUN apk add --update --no-cache bind-tools curl libcap bash net-tools openssl
 ---> Using cache
 ---> d8da6ad0cd70
Step 5/11 : RUN apk upgrade --available
 ---> Using cache
 ---> c5e9a2b544f6
Step 6/11 : RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C /
 ---> Using cache
 ---> 4a50c1091003
Step 7/11 : RUN echo "========="
 ---> Using cache
 ---> 34d9c9196259
Step 8/11 : RUN curl -sSL https://github.com/janeczku/go-dnsmasq/releases/download/${GO_DNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /bin/go-dnsmasq &&     chmod +x /bin/go-dnsmasq &&     apk del curl &&     addgroup go-dnsmasq &&     adduser -D -g "" -s /bin/sh -G go-dnsmasq go-dnsmasq &&     setcap CAP_NET_BIND_SERVICE=+eip /bin/go-dnsmasq
 ---> Using cache
 ---> a3a5c9928394
Step 9/11 : COPY root /
 ---> Using cache
 ---> 3880760d00a4
Step 10/11 : ENTRYPOINT ["/init"]
 ---> Using cache
 ---> 8e790a7f2528
Step 11/11 : CMD []
 ---> Using cache
 ---> 7553de783868
Successfully built 7553de783868
Successfully tagged hackinglab/alpine-base:latest
```


## TESTING docker-compose.yml using `docker-compose config`
```
root@demide:/home/ibuetler/Repository/alpine-base-example# docker-compose config
services:
  alpine-base:
    environment:
      GOLDNUGGET: SED_GOLDNUGGET
    hostname: alpine-base
    image: hackinglab/alpine-base:latest
    volumes:
    - /home/ibuetler/Repository/alpine-base-example/6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn:/goldnugget/6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn:rw
    - /home/ibuetler/Repository/alpine-base-example/flag-deploy-scripts:/flag-deploy-scripts:rw
version: '3.4'
```

## RUNNING container using `docker-compose up`
```
root@demide:/home/ibuetler/Repository/alpine-base-example# docker-compose up
Starting alpine-base-example_alpine-base_1 ... done
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
alpine-base_1  | adduser: user 'hacker' in use
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
alpine-base_1  | 
alpine-base_1  | ====== testing for flag in /goldnugget folder ======
alpine-base_1  | flag file found in /goldnugget
alpine-base_1  | total 4
alpine-base_1  | -rw-r--r--    1 go-dnsma go-dnsma        26 Dec 10 08:58 6db3a534-70eb-40e5-8d6f-9839b46b53fb.gn
alpine-base_1  | what do you want to do with the flag file?
alpine-base_1  | please define what you want to do with the flag in /flag-deploy-scripts/deploy-file-flag.sh
alpine-base_1  | executing /flag-deploy-scripts/deploy-file-flag.sh
alpine-base_1  | put your commands to deploy the file based flag here
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
Hacking-Lab CTF docker containers are spinned up by a component called `docker manager`. Based on the per-docker configuration (not explained above and here), the docker manager will create random values and sets the flags throughout the ENV or FILE attribute. 




