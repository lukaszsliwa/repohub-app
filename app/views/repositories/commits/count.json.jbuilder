json.array! @dates do |date|
  result = @reference.commits_by_user(date, date)
  json.date date.to_date.to_s
  json.count result.sum { |item| item.count }
  json.commiters result do |line|
    json.count line.count
    json.author line.author
  end
end