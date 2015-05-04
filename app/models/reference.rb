class Reference < ActiveRecord::Base
  belongs_to :repository

  validates :name, presence: true

  def to_param
    name
  end
end
