FROM cznic/knot:latest

RUN  export DEBIAN_FRONTEND=noninteractive; \
     apt-get update && apt-get -y -qq install --no-install-recommends \
     ca-certificates \
     wget \
     gettext-base \
     iproute2 \
     jq \
     libknot-dev \
     daemonize \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && find /var/log -type f -delete

COPY myCA.crt /usr/local/share/ca-certificates/myCA.crt
RUN  update-ca-certificates
COPY --chmod=755 entrypoint.sh healthcheck.sh /

HEALTHCHECK --interval=5s CMD /healthcheck.sh 
ENTRYPOINT ["/entrypoint.sh"]



