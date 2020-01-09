# Alpine Base
## Introduction
This is the alpine base image of the Hacking-Lab CTF system

## Specifications
* with s6 startup handling
* with dynamic user creation
* with or without known passwords for root and non-root user
* with `env` based dynamic ctf flag handling
* with `file` based dynamic ctf flag handling

## Build & Test
1. `bash build.sh`
2. `docker-compse -f docker-compose-local.yml up`
3. base image is not providing any service


## Testing only (without building)
1. `docker pull hackinglab/alpine-nginx:latest`
2. `docker-compose -f docker-compose-local.yml up`
3. base image is not providing any service 


