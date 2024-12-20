#!/bin/sh
DOCKER_BUILDKIT=1 docker build $1 . -t bind9:latest
