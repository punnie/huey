FROM ruby:2.7.2-slim-buster AS base

# install system tools/libs
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  && apt-get autoremove -y --force-yes \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# setup home directory
ENV APP_HOME /usr/src/app/
ENV PATH=$APP_HOME/bin:$PATH
WORKDIR $APP_HOME

# install bundler and gem dependencies
RUN gem install bundler -v 2.1.4
COPY Gemfile Gemfile.lock $APP_HOME

RUN echo "gem: --no-document" >> ~/.gemrc \
  && bundle config no-cache 'true' \
  && bundle config jobs `expr $(nproc --all) - 1` \
  && bundle config retry 3 \
  && bundle install \
  && rm -rf /usr/local/bundle/cache/* \
  && rm -rf /root/.bundle/cache

FROM ruby:2.7.2-slim-buster

# setup home directory
ENV APP_HOME /usr/src/app/
ENV PATH=$APP_HOME/bin:$PATH
WORKDIR $APP_HOME

# install system tools/libs
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libpq5 \
  && apt-get autoremove -y --force-yes \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=base /usr/local/ /usr/local/
COPY . $APP_HOME
