#!/usr/bin/env bash

CONFIG="/config/knot.conf"

# make sure knot is PID 1 in the container so it can receive and respond to signals from either docker or systemd
exec knotd -c /config/knot.conf

