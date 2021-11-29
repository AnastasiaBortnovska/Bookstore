release: bundle exec rake db:migrate
web: bin/start-nginx bundle exec puma -e production -p ${PORT_PUMA:-3000} -C config/puma.rb -b unix:///app/tmp/nginx.socket
