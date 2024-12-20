#!/bin/sh
docker container stop knotdns
docker container prune -f
rm rundir/dbus.sock
