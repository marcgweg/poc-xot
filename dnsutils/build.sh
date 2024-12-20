#!/bin/sh
DOCKER_BUILDKIT=1 docker build --no-cache . -t dnsutils:latest
