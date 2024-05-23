# Base stage
FROM ruby:3.0.2-alpine3.14 as base
ENV BUILD_PACKAGES="build-base postgresql-dev nodejs npm yarn tzdata bash curl" \
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

# Yarn stage
FROM bundle AS yarn
COPY package.json yarn.lock ./
RUN apk add --update --no-cache yarn && \
    yarn install

# Final stage
FROM yarn as dev-server
COPY . .
EXPOSE 3000
CMD ["foreman", "start"]
