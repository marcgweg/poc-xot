# Build file for a very basic nsd container
# config and files to run nsd must be supplied through volumes
# docker build -t nsd-stiab:latest -f dockerfiles/Dockerfile.nsd . &&  docker system prune -f && docker buildx prune -f
FROM debian:bookworm-slim AS nsd-build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y -qq install --no-install-recommends \
    build-essential \
    libssl-dev \
    libevent-dev \
    bison \
    flex \
    coreutils \
    curl \
    ca-certificates \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && find /var/log -type f -delete

RUN mkdir /src && \
    LATEST_VERSION=$(curl -s -w '%{redirect_url}\n' -o /dev/null https://github.com/NLnetLabs/nsd/releases/latest | awk -F "_" '{print $2 "." $3 "." $4}') && \
    mkdir -p /build/nsd-${LATEST_VERSION}/DEBIAN && \
    curl -O -L https://nlnetlabs.nl/downloads/nsd/nsd-${LATEST_VERSION}.tar.gz && \
    curl -o checksums.txt -L https://nlnetlabs.nl/downloads/nsd/nsd-${LATEST_VERSION}.tar.gz.sha256 && \
    sed -i '$ s/$/ nsd-'${LATEST_VERSION}'.tar.gz/' checksums.txt && \
    sha256sum -c checksums.txt 2>/dev/null | grep OK && tar xzf nsd-${LATEST_VERSION}.tar.gz --directory=/src && \
    cd /src/nsd-${LATEST_VERSION} && \
    export CFLAGS="-s" && \
    ./configure --prefix=/build/nsd-${LATEST_VERSION}/usr --sysconfdir=/etc --localstatedir=/var && \
    make && \
    make install

COPY DEBIAN-control /build/control
WORKDIR /build
RUN ls -lR && mv control nsd-*/DEBIAN/ && sed -i "s/VERSION/$(echo nsd-* | cut -d'-' -f2)/" nsd-*/DEBIAN/control && \
    dpkg-deb --build nsd-*


FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y -qq install --no-install-recommends \
    daemonize \
    openssl \
    libevent-dev \
    inotify-tools \
    curl \
    procps \
    ca-certificates \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && find /var/log -type f -delete

# Install NSD from Debian package
COPY --from=nsd-build /build/nsd-*.deb /
RUN dpkg -i /nsd-*.deb && rm /nsd-*.deb && \
    mkdir -p /etc/nsd && mkdir -p /var/db/nsd
RUN nsd-control-setup

COPY myCA.crt /usr/local/share/ca-certificates/myCA.crt
RUN  update-ca-certificates

CMD ["/sbin/nsd", "-d", "-c", "/config/nsd.conf"]
