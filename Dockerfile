FROM centos:centos7

# This image is the base image for all OpenShift v3 language Docker images.
MAINTAINER Jakub Hadvig <jhadvig@redhat.com>

# This is the list of basic dependencies that all language Docker image can
# consume.
RUN rpmkeys --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum install -y --setopt=tsflags=nodocs \
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
    make \
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

# Create directory where the image STI scripts will be located
# Install the base-usage script with base image usage informations
ADD bin/base-usage /usr/local/sti/base-usage

# Location of the STI scripts inside the image
ENV STI_SCRIPTS_URL image:///usr/local/sti

# The $HOME is not set by default, but some applications needs this variable
ENV HOME /opt/openshift/src

# Setup the 'openshift' user that is used for the build execution and for the
# application runtime execution.
# TODO: Use better UID and GID values
RUN mkdir -p ${HOME} && \
    groupadd -r default -f -g 1001 && \
    useradd -u 1001 -r -g default -d ${HOME} -s /sbin/nologin \
            -c "Default Application User" default && \
    chown -R default:default "${HOME}/.."

ENV PATH ${HOME}/bin:/usr/local/sti:$PATH

# Directory with the sources is set as the working directory so all STI scripts
# can execute relative to this path
WORKDIR ${HOME}

# These instruction triggers the instructions at a later time, when the image
# is used as the base for another build.
#
# Copy the STI scripts from the specific language image to /usr/local/sti
ONBUILD COPY ./.sti/bin/ /usr/local/sti

# Set the default CMD to print the usage of the language image
ONBUILD CMD ["usage"]

CMD ["base-usage"]
