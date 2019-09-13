class AddWatcherMailer < Mailer
  # Builds a mail for notifying user about he is added as issue's watcher
  def watch_issue(user, issue)
    references issue
    @author = issue.author
    @issue = issue
    @user = user
    @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue)
    if Setting.plugin_redmine_add_watcher_notifier['subject'].blank?
      subject = l(:default_subject, issue: @issue.id, scope: :add_watcher_notifier)
    else
      subject = mail_fiddler_format(Setting.plugin_redmine_add_watcher_notifier['subject'], issue )
    end

    mail to: user.mail, subject: subject
  end

  private

  def mail_fiddler_format(fmt_string, issue)
    fmt_string.gsub(/(\{(project|tracker|issue_id|subject|status)\})/i).each do |w|
      case w.downcase
      when "{project}"
        issue.project.name
      when "{tracker}"
        issue.tracker.name
      when "{issue_id}"
        "##{issue.id}"
      when "{subject}"
        issue.subject
      when "{status}"
        issue.status.name
      end
    end
  end
end
