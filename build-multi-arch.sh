#!/bin/bash

docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/alpine-base:latest . --push
docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/alpine-base:$1  . --push
docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/alpine-base:$1.0 . --push

