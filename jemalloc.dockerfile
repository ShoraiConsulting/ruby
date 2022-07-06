ARG FEDORA_VERSION
FROM registry.fedoraproject.org/fedora-minimal:${FEDORA_VERSION}

ARG RUBY_VERSION

RUN microdnf --nodocs -y upgrade && \
    microdnf --nodocs -y install fedora-repos-modular && \
    microdnf module enable -y ruby:${RUBY_VERSION} && \
    microdnf module enable -y nodejs:14 && \
    microdnf --nodocs install -y \
    autoconf \
    automake \
    bash \
    bison \
    bzip2 \
    curl-devel \
    cronie \
    gcc-c++ \
    git-core \
    jemalloc \
    libffi-devel \
    libpq-devel \
    libtool \
    libyaml-devel \
    libxml2-devel \
    libxslt-devel \
    make \
    nano \
    nodejs \
    openssl-devel \
    patch \
    postgresql \
    procps-ng \
    redhat-rpm-config \
    ruby \
    ruby-devel \
    readline-devel \
    shared-mime-info \
    sqlite-devel \
    vim \
    zlib \
    zlib-devel \
    $ADDITIONAL_PACKAGES && \
    microdnf --nodocs reinstall -y tzdata && \
    microdnf clean all

ENV LD_PRELOAD=/usr/lib64/libjemalloc.so.2

ONBUILD ARG UID=1000
ONBUILD RUN useradd -d /ruby -l -m -Uu ${UID} -r -s /bin/bash ruby && \
    chown -R ${UID}:${UID} /ruby

RUN gem install bundler
