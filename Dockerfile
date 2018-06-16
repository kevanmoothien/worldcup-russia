FROM heroku/heroku:16
MAINTAINER Kevan Moothien <kevanmoothien@gmail.com>

RUN apt-get update -qq && \
  apt-get install -y -qq --no-install-recommends \
    build-essential\
    libpq-dev\
    libxml2-dev\
    libxslt1-dev\
    libsqlite3-dev \
    qt5-default\
    libqt5webkit5-dev\
    gstreamer1.0-plugins-base\
    gstreamer1.0-tools\
    gstreamer1.0-x\
    xvfb \
    ruby-dev \
    wget \
    unzip \
    libnss3 \
    libgconf-2-4 \
    sudo \
  && apt-get autoremove \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* \
  && truncate -s 0 /var/log/*log

# Ruby heroku
RUN apt-get remove -y --purge ruby && curl -s --retry 3 -L https://heroku-buildpack-ruby.s3.amazonaws.com/heroku-16/ruby-2.5.0.tgz | tar -xz && \
  gem install bundler && \
  bundle config --global silence_root_warning 1


# Node heroku
RUN export NODE_VERSION=8.9.4 && \
  curl -s --retry 3 -L https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz -o /tmp/node-v$NODE_VERSION-linux-x64.tar.gz && \
  tar -xzf /tmp/node-v$NODE_VERSION-linux-x64.tar.gz -C /tmp && \
  rsync -a /tmp/node-v$NODE_VERSION-linux-x64/ / && \
  rm -rf /tmp/node-v$NODE_VERSION-linux-x64*

RUN adduser --gecos '' user && passwd -d user && adduser user sudo

RUN mkdir -p /bundle
RUN chown user:user /bundle

USER user

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle

ENV PATH="/home/user/bin:$PATH"

WORKDIR /home/user

EXPOSE 3000
EXPOSE 3001

# COPY . /var/app

CMD bash
