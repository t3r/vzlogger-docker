FROM debian:stretch

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install \
      build-essential \
      curl \
      cmake \
      dh-autoreconf \
      git-core \
      gnutls-dev \
      jq \
      libcurl3-dev \
      libsasl2-dev \
      libtool \
      libgcrypt20-dev \
      libssl-dev \
      libmicrohttpd-dev \
      libunistring-dev \
      libmosquitto-dev \
      pkg-config \
      subversion \
      sudo \
      uuid-dev \
      uuid-runtime && \
    mkdir /tmp/build && \
    cd /tmp/build && \
    curl -L --fail -O https://raw.github.com/volkszaehler/vzlogger/master/install.sh && \
    touch /etc/systemd/system/vzlogger.service && \
    bash -x ./install.sh && \
    cd / && rm -rf /tmp/build && \
    export SUDO_FORCE_REMOVE=yes && \
    apt-get -y purge \
      build-essential \
      cmake \
      dh-autoreconf \
      git-core \
      libtool \
      pkg-config \
      subversion \
      sudo && \
    apt-get -y autoremove && \
    apt-get clean

#USER nobody
ENTRYPOINT [ "/usr/local/bin/vzlogger" ]

