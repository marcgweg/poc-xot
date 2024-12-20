FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \ 
&&  apt-get -y -qq install --no-install-recommends \
       bind9 \
       ca-certificates \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && find /var/log -type f -delete

COPY myCA.crt /usr/local/share/ca-certificates/myCA.crt
RUN  update-ca-certificates

CMD ["/usr/sbin/named", "-g", "-c", "/config/named.conf"]
