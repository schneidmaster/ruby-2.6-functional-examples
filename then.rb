# Adapted from: https://zverok.github.io/blog/2018-01-24-yield_self.html

require "json"
require_relative "api"

# Traditional/imperative ruby
def server_id
  url = "https://myapi.com"
  response = API.get(url)
  data = JSON.parse(response)
  id = data.dig("object", "id") || "<undefined>"
  "server:#{id}"
end
puts "server_id: #{server_id}"

# then (definitely not yield_self >_>)
def server_id_then
  "https://myapi.com"
    .then { |url| API.get(url) }
    .then { |response| JSON.parse(response) }
    .dig("object", "id")
    .then { |id| id || "<undefined>" }
    .then { |id| "server:#{id}" }
end
puts "server_id with then: #{server_id_then}"

# then with method shorthand
def server_id_then_method
  "https://myapi.com"
    .then(&API.method(:get))
    .then(&JSON.method(:parse))
    .dig("object", "id")
    .then { |id| id || "<undefined>" }
    .then { |id| "server:#{id}" }
end
puts "server_id with then and method shorthand: #{server_id_then_method}"
