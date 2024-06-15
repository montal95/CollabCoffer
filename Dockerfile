# Base stage
FROM ruby:3.3.1-alpine3.20 as base
ENV BUILD_PACKAGES="build-base postgresql-dev tzdata bash curl" \
    APP_HOME="/opt/app"
RUN apk update \
    && apk upgrade \
    && apk add --no-cache $BUILD_PACKAGES \
    && rm -rf /var/cache/apk/*

WORKDIR $APP_HOME

# Bundle stage
FROM base AS bundle
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.4.19 && \
    bundle install

# Final stage
FROM bundle as dev-server
COPY . .
EXPOSE 3000
CMD ["bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]
