FROM python:2.7.12-slim
MAINTAINER Panmax <jiapan.china@mail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD sources.list.jessie.txt /etc/apt/sources.list

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    curl

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
 && echo '\
deb https://deb.nodesource.com/node_5.x jessie main\n\
deb-src https://deb.nodesource.com/node_5.x jessie main\n\
' > /etc/apt/sources.list.d/nodesource.list \
 && echo '\
Package: nodejs\n\
Pin: origin deb.nodesource.com\n\
Pin-Priority: 900\n\
' > /etc/apt/preferences.d/nodesource

RUN apt-get update \
 && apt-get install -y --no-install-recommends --fix-missing \
    nodejs \
    git \
    graphicsmagick \
    gfortran \
    netcat \
    redis-tools \
    mariadb-client \
    postgresql-client \
    libffi-dev \
    libopenblas-dev \
    liblapack-dev \
    libblas-dev \
    libatlas-dev \
    libfreetype6-dev \
    libmagickwand-dev \
    libmemcached-dev \
    libmysqlclient-dev \
    libpq-dev \
    libjpeg-dev \
    libzlcore-dev \
    librsvg2-dev \
    libtiff5-dev \
    liblcms2-dev \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    libcap-dev \
    libsasl2-dev \
    libldap2-dev \
    libssl-dev \
    build-essential

#RUN curl -s https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 | tar xvj -C /opt/ \
# && mv /opt/phantomjs-1.9.8-linux-x86_64/ /opt/phantomjs/
#
#ENV PATH "/opt/phantomjs/bin:$PATH"

ADD pip.conf /etc/pip.conf.custom
RUN pip install --no-cache-dir --no-binary cryptography virtualenv