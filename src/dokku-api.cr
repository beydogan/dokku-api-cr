require "./dokku-api/*"
require "kemal"
require "json"

post  "/commands" do |env|
  env.response.content_type = "application/json"
  params = ""
  command = env.params.body["command"].as(String)
  if env.params.body.has_key?("params")
    params = env.params.body["params"].as(String)
  end

  c = Command.new(command, params.split(" "))
  result = c.run

  result.to_json
end

Kemal.run
