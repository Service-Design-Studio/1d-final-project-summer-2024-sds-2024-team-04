# Dockerfile for Rails Backend

# Use the official lightweight Ruby image
FROM ruby:3.3.3 AS rails-toolbox

# Install dependencies
RUN apt-get update && apt-get install -y nodejs yarn build-essential libsqlite3-dev

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler -v 2.4.22 && bundle install

# Copy the rest of the code
COPY . .

# Set environment variables
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV SECRET_KEY_BASE=74b4f8658db4cc359c4f6d8401d043e91f449e10c18c958b1162b12e78fa6395c2860ca4b5da7b83228103a12042259b1d6ab9d67d938a3946a17000133ba239

# Precompile assets and prepare the database
RUN bundle exec rake assets:precompile
RUN bundle exec rake db:setup

# Expose port 8080 to the outside world
EXPOSE 8080

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]
