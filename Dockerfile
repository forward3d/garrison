FROM ruby:2.6-alpine3.10 as build

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV

RUN apk add --no-cache libxml2-dev libxslt-dev build-base postgresql-dev yarn tzdata

RUN mkdir -p /usr/src/garrison
WORKDIR /usr/src/garrison

COPY Gemfile Gemfile.lock /usr/src/garrison/

RUN set -ex; \
  if [ "$RAILS_ENV" = "production" ]; then \
    bundle install --jobs "$(getconf _NPROCESSORS_ONLN)" --retry 5 --without test development; \
  elif [ "$RAILS_ENV" = "development" ]; then \
    bundle install --jobs "$(getconf _NPROCESSORS_ONLN)" --retry 5; \
  fi;

RUN rm /usr/local/bundle/cache/*.gem

COPY package.json yarn.lock /usr/src/garrison/
RUN set -ex; \
  if [ "$RAILS_ENV" = "production" ]; then \
    yarn install --frozen-lockfile --production && yarn cache clean; \
  elif [ "$RAILS_ENV" = "development" ]; then \
    yarn install --frozen-lockfile && yarn cache clean; \
  fi;

COPY . /usr/src/garrison
RUN SECRET_KEY_BASE=1 bundle exec rake assets:precompile

RUN rm -rf /usr/src/garrison/app/assets
RUN rm -rf /usr/src/garrison/node_modules
RUN rm -rf /usr/src/garrison/tmp
RUN find /usr/local/bundle -iname '*.o' -exec rm {} \;
RUN find /usr/local/bundle -iname '*.a' -exec rm {} \;

# RUNTIME CONTAINER
FROM ruby:2.6-alpine3.10

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV

RUN apk upgrade --no-cache
RUN apk add --no-cache libpq tzdata

WORKDIR /usr/src/garrison
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /usr/src/garrison /usr/src/garrison

ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

RUN set -ex; \
  if [ "$RAILS_ENV" = "production" ]; then \
    bundle install --without assets;\
  elif [ "$RAILS_ENV" = "development" ]; then \
    bundle install;\
    apk add --no-cache build-base nodejs; \
  fi;

EXPOSE 3000
CMD ["bin/entry"]
