class Branch < Reference
  after_commit :on_create_notification, on: :create
  after_commit :on_destroy_notification, on: :destroy

  def on_create_notification
    repository.notifications.create resource_name: 'repository:branch:create', message: "@#{created_by.username} created new branch %#{name}"
    if repository.space.present?
      repository.space.notifications.create resource_name: 'repository:branch:create', message: "^#{repository.handle_with_space} has new branch %#{name}"
    end
    repository.users.each do |member|
      member.notifications.create resource_name: 'repository:commit:create', message: "@#{created_by.username} created new branch %#{name} in ^#{repository.handle_with_space}"
    end
  end

  def on_destroy_notification
    repository.notifications.create resource_name: 'repository:branch:destroy', message: "@#{deleted_by.username} removed the branch %#{name}"
    if repository.space.present?
      repository.space.notifications.create resource_name: 'repository:branch:destroy', message: "Branch %#{name} was removed from ^#{repository.handle_with_space}"
    end
    repository.users.each do |member|
      member.notifications.create resource_name: 'repository:branch:destroy', message: "@#{created_by.username} removed branch %#{name} from ^#{repository.handle_with_space}"
    end
  end
end