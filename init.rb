require 'redmine_add_watcher_notifier/add_watcher_notifier_logger'

Redmine::Plugin.register :redmine_add_watcher_notifier do
  name 'Redmine Add Watcher Notifier plugin'
  author 'Roberto Piccini'
  description <<-eos
    sends email notification to user when he is added as issue's watcher
    (puts 'config.active_record.observers = :watcher_observer' in config/additional_environment.rb)
  eos
  version '0.0.1'
  url 'https://github.com/piccio/redmine_add_watcher_notifier'
  author_url 'https://github.com/piccio'
  requires_redmine version: '2.6.0'

  settings default: { enable_log: false }, partial: 'settings/add_watcher_notifier'
end