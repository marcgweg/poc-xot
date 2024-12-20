#!/bin/sh
#
docker run -d -it --name distns \
	-p 1053:53/udp -p 1053:53/tcp \
	-v "/home/debian/devel/bind/storage:/storage" \
	-v "/home/debian/devel/bind/config:/config" \
	bind9:latest 
