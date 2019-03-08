require "json"
require_relative "api"

# Declare some procs
times_five = ->(num) { num * 5 }
plus_two = ->(num) { num + 2 }

# Compose them!
times_five_plus_two = times_five >> plus_two
plus_two_times_five = times_five << plus_two

puts "3 * 5 + 2 = #{times_five_plus_two.call(3)}"
puts "(3 + 2) * 5 = #{plus_two_times_five.call(3)}"

# You can also compose the composed procs
strong_independent_number = ->(num) {
  <<~NUMBER
  ╔═════════════════ ೋღ☃ღೋ ════════════════╗
  ~ ~ ~ ~ ~ ~ ~ Repost this if ~ ~ ~ ~ ~ ~
  ~ ~ ~ ~ you are a beautiful #{num} ~ ~ ~ ~ ~
  ~ ~ ~ ~ ~ who don’t need no man ~ ~ ~ ~
  ╚═════════════════ ೋღ☃ღೋ ════════════════╝
  NUMBER
}

pretty_times_five_plus_two = times_five_plus_two >> strong_independent_number
puts pretty_times_five_plus_two.call(3)

# Variant on the server_id then example
server_id_procs =
  API.method(:get) \
    >> JSON.method(:parse) \
    >> ->(response) { response.dig("object", "id") } \
    >> ->(id) { id || "<undefined>" } \
    >> ->(id) { "server:#{id}" }

puts "server_id_procs: #{server_id_procs.call('https://myapi.com')}"
