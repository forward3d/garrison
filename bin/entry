#!/bin/sh
set -e

bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec puma -C config/puma.rb

exec "$@"
