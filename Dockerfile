FROM ruby:2.7.2-alpine

ENV APP_HOME /app
ENV APP_USER app_owner

RUN apk add --update --virtual \
    runtime-deps \
    postgresql-client \
    build-base \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    yarn \
    libffi-dev \
    readline \
    postgresql-dev \
    libc-dev \
    linux-headers \
    readline-dev \
    file \
    tzdata \
    bash \
    curl \
    git \
    && rm -rf /var/cache/apk/*

WORKDIR $APP_HOME

COPY Gemfile* ./
RUN bundle install
RUN yarn install

COPY . .

RUN RAILS_ENV=development rake assets:precompile

EXPOSE 3000

ENTRYPOINT ["sh", "/usr/src/app/docker-entrypoint.sh"]
