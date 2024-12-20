#!/bin/sh
DOCKER_BUILDKIT=1 docker build $1 . -t nsd:latest
