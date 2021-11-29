# frozen_string_literal: true
require 'fileutils'

max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count
preload_app!

worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

port ENV.fetch('PORT_PUMA', 3000)
environment ENV.fetch('RAILS_ENV', 'development')
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
plugin :tmp_restart
