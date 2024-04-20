# weby/router.rb

require 'singleton'
require 'debug'

require_relative 'controllers/articles_controller'

class Router
  include Singleton

  attr_reader :routes

  class << self
    def draw(&blk)
      Router.instance.instance_exec(&blk)
    end
  end

  def initialize
    @routes = {}
  end

  def get(path, &blk)
    if blk
      @routes[path] = blk
    else
      @routes[path] = ->(env) {
        controller_name, action_name = find_controller_action(path)
        controller_klass = constantize(controller_name)
        controller = controller_klass.new(env)
        
        controller.send(action_name.to_sym)
      }
    end
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || ->(env) { "no route found for #{path}" }
    handler.call(env)
  end

  private

  # input: '/articles/index'
  # output: ['articles', 'index']
  def find_controller_action(path)
    result = path.match /\/(\w+)\/(\w+)\/?/
    controller = result[1]
    action = result[2]
    return controller, action
  end
  
  # input: 'articles'
  # output: ArticlesController
  def constantize(name)
    controller_klass_name = name.capitalize + 'Controller'
    Object.const_get(controller_klass_name)
  end
end