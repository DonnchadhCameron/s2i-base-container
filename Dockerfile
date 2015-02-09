FROM centos:centos7

RUN yum install -y --setopt=tsflags=nodocs \
    autoconf \
    automake \
    bsdtar \
    curl-devel \
    epel-release \
    gcc-c++ \
    gdb \
    gettext \
    libxml2-devel \
    libxslt-devel \
    lsof \
    mysql-devel \
    mysql-libs \
    openssl-devel \
    postgresql-devel \
    procps-ng \
    sqlite-devel \
    tar \
    unzip \
    wget \
    which \
    yum-utils \
    zlib-devel && \
    yum clean all -y
