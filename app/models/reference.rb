class Reference < ActiveRecord::Base
  belongs_to :repository

  validates :name, presence: true

  def commits_by_user(from, to)
    since_attr = from.nil? ? '' : "--since='#{from.to_date} 00:00:00 +0000'"
    until_attr = to.nil? ? '' : "--until='#{to.to_date} 23:59:59 +0000'"
    output = `cd #{repository.path} && git shortlog -s -n #{since_attr} #{until_attr} #{name}`
    output.lines.map do |line|
      matcher = /\A([0-9]+)\t(.+)\z/.match line.strip
      OpenStruct.new(count: matcher[1].to_i, author: matcher[2])
    end
  end

  def to_param
    name
  end
end
