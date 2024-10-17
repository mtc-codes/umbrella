require "http"
require "json"
require "dotenv/load"


# Kickoff
prompt = "+++ Query: Will you need an umbrella today? +++"

puts prompt

lead = "Where are you currently located?"

pp lead

location = gets.chomp

pp "You are located in: " + location + "!"

# Pull coordinates from Google Maps
gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address="

gmap_query = gmap_url + location.gsub(" ","%20") + "&key=" + ENV.fetch("GMAPS_KEY")

pp gmap_query
gmap_raw = HTTP.get(gmap_query)
gmap_parsed = JSON.parse(gmap_raw)

coordinates = gmap_parsed.fetch("location")

pp "Your coordinates are: " + coordinates.to_s

# Put Coordinates into Pirate Weather to pull weather

pirate_weather_url = "https://api.pirateweather.net/forecast/"
pirate_weather_query = pirate_weather_key + ENV.fetch(PIRATE_WEATHER_KEY) + "/" + coordinates
pirate_weather_raw = HTTP.get(pirate_weather_query)
pirate_weather_parsed = JSON.parse(pirate_weather_raw)

# Desired Weather Results

currently = pirate_weather_parsed.fetch("currently")
temperature = pirate_weather_parsed.fetch("temperature")
summary = pirate_weather_parsed("summary")

puts "The current temperature is: " + temperature.to_s + "."
puts "It is currently " + summary + "."
