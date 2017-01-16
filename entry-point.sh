#!/bin/bash

cd /mypass
echo "Starting Entry Point Script = entry-point.sh........ "
echo "Populating Data in DB.........."
bundle exec rake db:migrate
echo "Running Application............"
bundle exec rackup -s Puma

