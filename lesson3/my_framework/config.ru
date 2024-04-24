# config.ru
# bundle exec rackup config.ru -p 9595

require_relative 'app'

run App.new
