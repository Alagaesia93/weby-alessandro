class App
  def call(env)
    headers = {
      "content-type" => "text/html"
    }
    response = ["<h1>Hello World!</h1>"]

    [200, headers, response]
  end
end