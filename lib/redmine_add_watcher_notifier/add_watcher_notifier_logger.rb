module RedmineAddWatcherNotifier
  class AddWatcherNotifierLogger < Logger
    def self.write(level, message)
      if Setting.plugin_redmine_add_watcher_notifier[:enable_log] == 'true'
        logger ||= new("#{Rails.root}/log/add_watcher_notifier.log")
        logger.send(level, message)
      end
    end
  end
end
