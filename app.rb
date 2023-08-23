require "sinatra"
require "sinatra/reloader"

require "http"
require "json"



$currencyList = ["AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN",
"BAM","BBD","BDT","BGN","BHD","BIF","BMD","BND","BOB","BRL",
"BSD","BTC","BTN","BWP","BYN","BZD","CAD","CDF","CHF","CLF",
"CLP","CNH","CNY","COP","CRC","CUC","CUP","CVE","CZK","DJF",
"DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","GBP",
"GEL","GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL",
"HRK","HTG","HUF","IDR","ILS","IMP","INR","IQD","IRR","ISK",
"JEP","JMD","JOD","JPY","KES","KGS","KHR","KMF","KPW","KRW",
"KWD","KYD","KZT","LAK","LBP","LKR","LRD","LSL","LYD","MAD",
"MDL","MGA","MKD","MMK","MNT","MOP","MRO","MRU","MUR","MVR",
"MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD",
"OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON",
"RSD","RUB","RWF","SAR","SBD","SCR","SDG","SEK","SGD","SHP",
"SLL","SOS","SRD","SSP","STD","STN","SVC","SYP","SZL","THB",
"TJS","TMT","TND","TOP","TRY","TTD","TWD","TZS","UAH","UGX",
"USD","UYU","UZS","VEF","VES","VND","VUV","WST","XAF","XAG",
"XAU","XCD","XDR","XOF","XPD","XPF","XPT","YER","ZAR","ZMW",
"ZWL"]


get("/") do
  @generate = $currencyList
 erb(:choose1)
end


#check on how to capture the response for the exchange
get("/:currency") do
 
  @generate = $currencyList
  ex = params[:currency].to_s
  @curr = ex
  exchange(ex)
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
