#!/bin/sh
#
docker run -d -it --name knotdns \
	--network host \
	-v "/home/debian/devel/knot/storage:/storage:rw" \
	-v "/home/debian/devel/knot/rundir:/rundir:rw" \
	-v "/home/debian/devel/knot/config:/config:ro" \
	knotdns:latest /sbin/knotd
