# require 'bundler/setup'
require 'rack'
# require 'rack/handler/webrick'

class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/plain" }, ["hello world"]]
  end
end

Rack::Handler::WEBrick.run MyApp.new
