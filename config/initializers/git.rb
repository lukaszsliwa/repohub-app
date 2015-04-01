require 'git'

Git.configure do |config|
  # If you want to use a custom git binary
  config.binary_path = 'sudo /usr/bin/git'
end