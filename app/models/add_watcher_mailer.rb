class AddWatcherMailer < Mailer
  # Builds a mail for notifying user about he is added as issue's watcher
  def watch_issue(user, issue)
    @author = issue.author
    @issue = issue
    @users = [user]
    @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue)
    mail to: user.mail,
         subject: l(:added_as_watcher_subject, issue: @issue.id, scope: :add_watcher_notifier)
  end
end