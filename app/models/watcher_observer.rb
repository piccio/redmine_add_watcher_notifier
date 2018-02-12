class WatcherObserver < ActiveRecord::Observer
  def after_create(watcher)
    RedmineAddWatcherNotifier::AddWatcherNotifierLogger.write(:info, 'adding a watcher')
    watchable = watcher.watchable
    user = watcher.user
    if watchable.is_a?(Issue) && user != User.current && user.mail.present?
      RedmineAddWatcherNotifier::AddWatcherNotifierLogger.write(:info, 'adding issues\' watcher')
      # Notifies user about he is added as issue's watcher
      AddWatcherMailer.watch_issue(user, watchable).deliver
      RedmineAddWatcherNotifier::AddWatcherNotifierLogger.write(
        :debug, "notified #{user.mail}: added as watcher to issue ##{watchable.id} by #{User.current.login}")
    end
  rescue => e
    # log error
    RedmineAddWatcherNotifier::AddWatcherNotifierLogger.write(:error, "ERROR=#{e.message}")
    RedmineAddWatcherNotifier::AddWatcherNotifierLogger.write(:error, "BACKTRACE=\n#{e.backtrace.join("\n")}")
    # re-raise error
    raise e
  end
end