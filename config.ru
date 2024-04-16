require 'rack'
require_relative './app'

app = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::Logger
  use Rack::Reloader, 0
  
  map "/welcome" do
    run App.new
  end
end

run app