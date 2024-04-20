require 'debug'
require_relative './config/routes'

class App
  attr_reader :router

  def call(env)
    headers = { 'content-type' => 'text/html' }
    
    response_html = router.build_response(env)
    
    [200, headers, [response_html]]
  end

  private
  def router
    Router.instance
  end
end