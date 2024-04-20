require_relative '../router'

Router.draw do
  get('/') do |env|
    "ENV: #{env.keys.sort.join(', ')} <br/><br/> Foo"
  end

  get('/articles/index')
  
  get('/articles/1') { "First Article" }
end