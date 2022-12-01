# frozen_string_literal: true

namespace :unicorn do
  ##
  # Tasks
  ##
  desc 'Start unicorn for production env.'
  task start: :environment do
    config = Rails.root.join('config/unicorn.rb')
    sh "bundle exec unicorn_rails -c #{config} -E production -D"
  end

  desc 'Stop unicorn'
  task(stop: :environment) { unicorn_signal :QUIT }

  desc 'Restart unicorn with USR2'
  task(restart: :environment) { unicorn_signal :USR2 }

  desc 'Increment number of worker processes'
  task(increment: :environment) { unicorn_signal :TTIN }

  desc 'Decrement number of worker processes'
  task(decrement: :environment) { unicorn_signal :TTOU }

  desc 'Unicorn pstree (depends on pstree command)'
  task(pstree: :environment) do
    sh "pstree '#{unicorn_pid}'"
  end

  def unicorn_signal(signal)
    Process.kill signal, unicorn_pid
  end

  def unicorn_pid
    File.read('/var/www/gardenscheduler/tmp/pids/unicorn.pid').to_i
  rescue Errno::ENOENT
    raise 'Unicorn doesn\'t seem to be running'
  end
end
