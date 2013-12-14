#!/usr/bin/env puma

directory ENV['UNICORN_HOME'] || '.'

environment ENV['APP_RAILS_ENV']

pidfile ENV['APP_ROOT'] + "/shared/pids/puma.pid"

quiet
