class Tag < Reference
  after_commit :on_create_notification,  on: :create
  after_commit :on_destroy_notification, on: :destroy
  
  def on_create_notification
    repository.notifications.create resource_name: 'repository:tag:create', message: "@#{created_by.username} created new tag &#{name}"
    if repository.space.present?
      repository.space.notifications.create resource_name: 'repository:tag:create', message: "^#{repository.handle_with_space} has new tag &#{name}"
    end
    repository.users.each do |member|
      member.notifications.create resource_name: 'repository:tag:create', message: "@#{created_by.username} created tag &#{name} in ^#{repository.handle_with_space}"
    end
  end

  def on_destroy_notification
    repository.notifications.create resource_name: 'repository:tag:destroy', message: "@#{deleted_by.username} removed the tag &#{name}"
    if repository.space.present?
      repository.space.notifications.create resource_name: 'repository:tag:destroy', message: "Tag &#{name} was removed from ^#{repository.handle_with_space}"
    end
    repository.users.each do |member|
      member.notifications.create resource_name: 'repository:tag:destroy', message: "@#{created_by.username} removed tag &#{name} from ^#{repository.handle_with_space}"
    end
  end
end