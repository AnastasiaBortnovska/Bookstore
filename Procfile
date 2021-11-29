release: bundle exec rake db:migrate
web_puma: bundle exec puma -e production -C config/puma.rb -b unix:/tmp/nginx.socket
web: bin/start-nginx-solo
