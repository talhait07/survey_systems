FROM ruby:2.6.3

ARG APP_ROOT=/survey-systems
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock $APP_ROOT/

RUN gem install bundler -v 2.1.4

# install applications gems
RUN bundle install

# Copy application code
COPY . $APP_ROOT

# Expose the port to run the server
EXPOSE 3000

# change the access mode of entrypoint.sh
RUN ["chmod", "+x", "entrypoint.sh"]

# Set the entrypoint where the service start
ENTRYPOINT ./entrypoint.sh