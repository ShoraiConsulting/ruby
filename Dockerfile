FROM registry.fedoraproject.org/fedora-minimal:34

RUN microdnf install -y fedora-repos-modular-34-2.noarch && \
  microdnf module enable -y ruby:2.7 && \
  microdnf module enable -y nodejs:14 && \
  microdnf install -y \
  autoconf \
  automake \
  bash \
  bison \
  bzip2 \
  curl-devel \
  cronie \
  gcc-c++ \
  git-core \
  jemalloc-devel \
  libffi-devel \
  libtool \
  libyaml-devel \
  libxml2-devel \
  libxslt-devel \
  make \
  nodejs \
  openssl-devel \
  patch \
  postgresql-devel \
  redhat-rpm-config \
  ruby \
  ruby-devel \
  readline-devel \
  shared-mime-info \
  sqlite-devel \
  zlib \
  zlib-devel && \
  microdnf reinstall -y tzdata && \
  microdnf update -y && \
  microdnf clean all

ONBUILD ARG UID=1000
ONBUILD RUN useradd -d /ruby -l -m -Uu ${UID} -r -s /bin/bash ruby && \
  echo '. /etc/profile' >> /ruby/.profile && \
  chown -R ${UID}:${UID} /ruby

USER 1000:1000


ARG RUBY_CONFIGURE_OPTS=""
ARG RUBY_VERSION=2.7.3
RUN RUBY_CONFIGURE_OPTS="${RUBY_CONFIGURE_OPTS}" rbenv install ${RUBY_VERSION} && \
  rbenv global ${RUBY_VERSION} && \
  rbenv rehash && \
  gem install bundler

ONBUILD USER ${UID}:${UID}