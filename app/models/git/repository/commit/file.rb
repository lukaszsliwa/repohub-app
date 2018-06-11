class Git::Repository::Commit::File < ActiveResource::Base
  attr_accessor :current_position

  def next_position
    self.current_position ||= 0
    self.current_position += 1
  end
end