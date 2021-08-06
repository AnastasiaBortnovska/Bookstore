FROM ruby:2.7.2-alpine
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
 build-base \
 postgresql-dev \
 libc-dev \
 linux-headers \ 
 readline-dev \
 file \
 imagemagick \
 git \
 tzdata \
&& rm -rf /var/cashe/apk/*
