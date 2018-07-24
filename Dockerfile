FROM bitnami/minideb:stretch as build1


# Required for retrieving source
RUN install_packages \
    bzip2 \
    ca-certificates \
    gnupg1 \
    wget

ENV PDNS_URL=https://downloads.powerdns.com/releases \
    PDNS_VERSION=4.1.3 \
    PDNS_GPG=0x5e50715bf2ffe1a7

# PowerDNS sources are signed.
RUN gpg1 --keyserver pgp.mit.edu --recv-keys \
    ${PDNS_GPG}
#
RUN wget -O pdns.tar.bz2 ${PDNS_URL}/pdns-${PDNS_VERSION}.tar.bz2 && \
    wget -O pdns.tar.bz2.asc ${PDNS_URL}/pdns-${PDNS_VERSION}.tar.bz2.sig && \
    gpg1 --verify pdns.tar.bz2.asc && \
    tar --strip-components=1 -jxvf pdns.tar.bz2 -C /tmp


## Required for building source
RUN install_packages \
    build-essential \
    file \
    libboost-all-dev \
    libcdb-dev \
    libcrypto++-dev \
    libgeoip-dev \
    libkrb5-dev \
    libldap2-dev \
    libmariadbd-dev \
    libpq-dev \
    libsodium-dev \
    libssl-dev \
    libsqlite3-dev \
    libyaml-cpp-dev \
    pkg-config \
    unixodbc-dev

RUN cd /tmp && \
    # Default modules 'bind gmysql random'
    ./configure --with-dynmodules='geoip godbc gpgsql gsqlite3 ldap mydns pipe remote tinydns' --without-lua --sysconfdir=/etc/pdns  && \
    make -j 9 && \
    make install-strip


FROM debian:9.5-slim

RUN apt-get update && apt-get -y --no-install-recommends install \
    libmariadbclient18 \
    libsodium18 \
    libsqlite3-0 \
    libssl1.1 && \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build1 /usr/local/bin /usr/local/bin/
COPY --from=build1 /usr/local/sbin /usr/local/sbin/
COPY --from=build1 /usr/local/lib/pdns /usr/local/lib/pdns/
COPY --from=build1 /etc/pdns /etc/pdns/

EXPOSE 53/tcp
EXPOSE 53/udp
