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
2. `docker-compose up`
3. base image is not providing any service

## USER SETTINGS
You can define the user that will being created in the docker. Please define these env variables in the docker-compose.yml file

* HL_USER_USERNAME=????
* HL_USER_PASSWORD=????
* HL_ROOT_PASSWORD=????


If you do not set these env variables, the base image will create the user "hacker" with the uid 2000 and random passwords (for both, hacker and root)



