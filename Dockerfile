# Use an official Ruby runtime as a parent image
FROM ruby:3.0.5-alpine

# Install necessary packages
RUN apk add --update --no-cache \
      build-base \
      postgresql-dev \
      nodejs \
      yarn \
      tzdata

# Set the working directory in the container to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install any needed packages specified in Gemfile
RUN bundle install

# Copy the current directory contents into the container at /app
COPY . .

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
