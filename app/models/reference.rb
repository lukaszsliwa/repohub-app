class Reference < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :repository

  validates :name, presence: true

  attr_accessor :deleted_by

  def to_param
    name
  end
end
