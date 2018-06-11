class Branch < Reference
  after_commit :on_create_notification, on: :create
  after_commit :on_destroy_notification, on: :destroy

  def on_create_notification
    Notification.create!(annotation: 'repository:branch:create', space_id: repository.space_id, repository_id: repository_id, user_id: created_by_id, resource_name: 'Branch', resource_id: id)
  end

  def on_destroy_notification
    Notification.create!(annotation: 'repository:branch:destroy', space_id: repository.space_id, repository_id: repository_id, user_id: created_by_id, resource_name: 'Branch', resource_id: id)
  end
end