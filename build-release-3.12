#!/bin/bash
docker build --no-cache -t hackinglab/alpine-base:$1.0 -t hackinglab/alpine-base:$1 -t hackinglab/alpine-base:latest -f Dockerfile .

docker push hackinglab/alpine-base:$1
docker push hackinglab/alpine-base:$1.0

