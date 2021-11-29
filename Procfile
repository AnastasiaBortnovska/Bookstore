release: bundle exec rake db:migrate
web: bin/start-nginx bundle exec puma -e production -C config/puma.rb -b unix:///app/tmp/nginx.socket
