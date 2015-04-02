class Commit < ActiveRecord::Base
  belongs_to :user
  belongs_to :repository
  belongs_to :branch

  def to_param
    sha
  end
end
