require "sinatra"
require "sinatra/reloader"

require "http"
require "json"

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

=begin
rupee = "rupee"
pp "What do you want to convert?"
userLocation = gets.chomp
=end
exachange_api = "https://api.exchangerate.host/symbols"
resp = HTTP.get(exachange_api)

raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

#Start to play with api
pp parsed_response.fetch("symbols").fetch("AED")
