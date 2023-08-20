require "sinatra"
require "sinatra/reloader"

require "http"
require "json"

get("/") do
 erb(:choose1)
end


#check on how to capture the response for the exchange
get("/AED") do
  ex = "AED"
  pp exchange(ex)
 erb(:choose2)
end

#missing go back feature
get("/AED/AFN") do

  @from = "AED"
  @to = "AFN"
  arr = exchangeFromTo(@from,@to)
  @current = arr[0]
  @exchange = arr[1]
  erb(:result)
end


def exchange(ex)
exachange_api = "https://api.exchangerate.host/symbols"
resp = HTTP.get(exachange_api)

raw_response = resp.to_s

parsed_response = JSON.parse(raw_response)

#Start to play with api
return parsed_response.fetch("symbols").fetch(ex).fetch("code")

end

def exchangeFromTo(from, to)
require 'net/http'
require 'json'

url = "https://api.exchangerate.host/convert?from=" + @from + "&to=" + @to
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)
pp queryFrom = response_obj.fetch("query").fetch("amount")
pp infoRate = response_obj.fetch("info").fetch("rate")
my_array = []
my_array.push(queryFrom.to_s)
my_array.push(infoRate.to_s)
return my_array
end
