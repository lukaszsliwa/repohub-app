module ApplicationHelper
  def current_reference
    if (name = @branch.try(:name) || @tag.try(:name)).nil?
      sha = @commit.try(:sha) || @tree.try(:sha)
      name = truncate(sha, length: 8, omission: '') if sha
    end
    name
  end

  def language_css_class_for(filename)
    case File.extname(filename)
    when '.rb' ; 'ruby'
    when '.haml' ; 'haml'
    when '.scss' ; 'scss'
    when '.css' ; 'css'
    when '.html' ; 'html'
    else 'not-recognized-file'
    end
  end

  def notification_image(notification, options = {})
    case
    when notification.repository_create? ; image_tag('circles/rocket.png', options)
    when notification.repository_destroy? ; image_tag('circles/denied.png', options)
    when notification.repository_user_create? ; image_tag('circles/profle.png', options)
    when notification.repository_user_destroy? ; image_tag('circles/denied.png', options)
    when notification.repository_tag_create? ; image_tag('circles/tag.png', options)
    when notification.repository_tag_destroy? ; image_tag('circles/denied.png', options)
    when notification.repository_branch_create? ; image_tag('circles/merge.png', options)
    when notification.repository_branch_destroy? ; image_tag('circles/denied.png', options)
    when notification.repository_commit_create? ; image_tag('circles/upload.png', options)
    else nil
    end
  end

  def notification_message(notification)
    message_pattern = notification_message_pattern notification
    keys = {}
    keys[:repository] = notification_message_repository_html(notification)
    keys[:user]       = notification_message_user_html(notification)
    keys[:branch]     = notification_message_branch_html(notification)   if notification.repository_branch?
    keys[:tag]        = notification_message_tag_html(notification)      if notification.repository_tag?
    keys[:commit]     = notification_message_commit_html(notification)   if notification.repository_commit?
    message_pattern ? raw(message_pattern % keys) : ''
  end

  def notification_message_repository_html(notification)
    link_to notification.repository.handle_with_space, [notification.repository.space, notification.repository], title: notification.repository.name
  end

  def notification_message_user_html(notification)
    if (user = notification.user).present?
      link_to user.username, user_path(user.username), title: user.full_name
    else
      notification.cached_name
    end
  end

  def notification_message_branch_html(notification)
    if (branch = notification.branch).present?
      link_to branch.name, url_for(space_id: notification.repository.space, repository_id: notification.repository, id: branch.name, controller: '/repositories/branches', action: 'show'), title: branch.name
    else
      notification.cached_name
    end
  end

  def notification_message_tag_html(notification)
    if (tag = notification.tag).present?
      link_to tag.name, url_for(space_id: notification.repository.space, repository_id: notification.repository, id: tag.name, controller: '/repositories/tags', action: 'show'), title: tag.name
    else
      notification.cached_name
    end
  end

  def notification_message_commit_html(notification)
    if (commit = notification.commit).present?
      link_to commit.short_sha, url_for(space_id: notification.repository.space, repository_id: notification.repository, id: commit.sha, controller: '/repositories/commits', action: 'show'), title: commit.sha
    else
      notification.cached_name
    end
  end

  def notification_message_pattern(notification)
    case
    when notification.repository_create? ; "@%{user} has created a repository %{repository}"
    when notification.repository_destroy? ; "@%{user} has deleted a repository %{repository}"
    when notification.repository_user_create? ; "Repository %{repository} has new member @%{user}"
    when notification.repository_user_destroy? ; "@%{user} was removed from the repository %{repository}"
    when notification.repository_tag_create? ; "@%{user} has created new tag %{tag}"
    when notification.repository_tag_destroy? ; "@%{user} has deleted tag %{tag}"
    when notification.repository_branch_create? ; "@%{user} has created new branch %{branch}"
    when notification.repository_branch_destroy? ; "@%{user} has deleted branch %{branch}"
    when notification.repository_commit_create? ; "@%{user} has pushed new commit #%{commit}"
    else nil
    end
  end

end
