#!/usr/bin/env bash

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
# Start the server
bundle exec rails db:create RAILS_ENV=development
bundle exec rails db:migrate RAILS_ENV=development
bundle exec rails db:seed RAILS_ENV=development
RAILS_ENV=development bundle exec rails s -b 0.0.0.0
