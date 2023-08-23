require "sinatra"
require "sinatra/reloader"

require "http"
require "json"

def exchange
  exachange_api = "https://api.exchangerate.host/symbols"
  resp = HTTP.get(exachange_api)
  
  raw_response = resp.to_s
  
  parsed_response = JSON.parse(raw_response)
  
  #Start to play with api
  return parsed_response
  
  end

$currencyList = exchange

get("/") do
  @generate = $currencyList
 erb(:choose1)
end


#check on how to capture the response for the exchange
get("/:currency") do
 
  @generate = $currencyList
  ex = params[:currency].to_s
  @curr = ex
  @hash = exchange
 erb(:choose2)
end

#missing go back feature
get("/:currency/:exchange") do

  @from = params[:currency].to_s
  @to = params[:exchange].to_s
  arr = exchangeFromTo(@from,@to)
  @current = arr[0]
  @exchange = arr[1]
  erb(:result)
end




def exchangeFromTo(from, to)
require 'net/http'
require 'json'

url = "https://api.exchangerate.host/convert?from=" + @from + "&to=" + @to
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)
queryFrom = response_obj.fetch("query").fetch("amount")
infoRate = response_obj.fetch("info").fetch("rate")
my_array = []
my_array.push(queryFrom.to_s)
my_array.push(infoRate.to_s)
return my_array
end
