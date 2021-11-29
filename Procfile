release: bundle exec rake db:migrate
puma: bundle exec puma -e production -C config/puma.rb -b unix:///app/tmp/nginx.socket
web: bin/start-nginx-solo 
