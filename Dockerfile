# Use an official Ruby runtime as a parent image
FROM ruby:3.0.2-alpine

# Install necessary packages
RUN apk add --update --no-cache \
      build-base \
      postgresql-dev \
      nodejs \
      npm \
      yarn \
      tzdata \
      bash \
      curl

# Install NVM
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Set the working directory in the container to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Bundler 2.4.19
RUN gem install bundler:2.4.19

# Install any needed packages specified in Gemfile
RUN bundle install

# Copy the package.json, yarn.lock, and .nvmrc into the container
COPY package.json yarn.lock .nvmrc ./

# Install any needed packages specified in package.json
RUN yarn install

# Copy the current directory contents into the container at /app
COPY . .

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the main process.
CMD ["foreman", "start"]
